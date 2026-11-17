#include "mapping.h"
#include "TMR01.h"
#include "Keypad.h"

// ---------------------------------------------------------------------------
// ENTRY CODES - edit here.
// A code can end with KEY_HASH (ENT) or not. A code without # triggers as soon
// as its last digit is pressed. No code may be the start of another code
// (e.g. 123 and 1234#), or the longer one can never be reached.
// ---------------------------------------------------------------------------
#define NORMAL_LEN 5
char Code_Normal[NORMAL_LEN] = {KEY_0, KEY_0, KEY_0, KEY_0, KEY_HASH};     // 0000#

#define EMERG_LEN  5
char Code_Emerg[EMERG_LEN]   = {1, 2, 3, 4, KEY_HASH};                     // 1234#

#define EMERG2_LEN 3
char Code_Emerg2[EMERG2_LEN] = {1, 2, 3};                                  // 123, no #  (longer wait)

// Reset code: only accepted during the 5-minute lock. Ends the lock early.
#define RESET_LEN  5
char Code_Reset[RESET_LEN]   = {KEY_STAR, 9, 9, 9, KEY_HASH};              // *999#

// States
#define ST_IDLE    0                 // locked, waiting for a code
#define ST_NORMAL  1                 // normal request: green blinking, waiting for flight crew UNLOCK
#define ST_EMERG   2                 // emergency code: wait, green blinking
#define ST_WINDOW  3                 // unlocked: green steady, door can be opened
#define ST_LOCKED  4                 // locked again: red, short timeout
#define ST_DENIED  5                 // flight crew selected LOCK: keypad inhibited
#define ST_EMERG2  6                 // second emergency code: longer wait, green blinking

// Durations in timer ticks (1 tick = 2.048 ms)
#define T_NORMAL   4883              // 10 s  time the flight crew have to select UNLOCK
#define T_EMERG    4883              // 10 s  emergency wait before auto unlock
#define T_EMERG2   14648             // 30 s  second emergency code wait before auto unlock
#define T_WINDOW   2441              // 5 s   time to open the door
#define T_LOCKED   1465              // 3 s   red after the window closes
#define T_DENIED   146484            // 5 min keypad inhibit after LOCK
#define T_BLINK    244               // 0.5 s on, 0.5 s off
#define T_ENTRY    4883              // 10 s without a key clears a partial entry

unsigned char door_state   = ST_IDLE;
unsigned long state_ticks  = 0;
unsigned int  blink_ticks  = 0;
unsigned int  entry_ticks  = 0;
unsigned char last_cnt     = 0;
unsigned char last_index   = 0;

// Door_Strike: 0 = locked (default), 1 = open. RC0 follows it directly (low = locked).
// BuzzerNormal (RC1): sounds during the normal and emergency waits
// Buzzer (RC2): key tone, driven in the main loop only
void enter_state(unsigned char s) {
 door_state  = s;
 state_ticks = 0;
 blink_ticks = 0;

 if (s == ST_IDLE) {
  Green_LED = 0; Red_LED = 0; BuzzerNormal = 0; Door_Strike = 0;
  clear_entry();
 }
 if (s == ST_NORMAL) {
  Green_LED = 1; Red_LED = 0; BuzzerNormal = 1; Door_Strike = 0;
 }
 if (s == ST_EMERG || s == ST_EMERG2) {
  Green_LED = 1; Red_LED = 0; BuzzerNormal = 1; Door_Strike = 0;
 }
 if (s == ST_WINDOW) {
  Green_LED = 1; Red_LED = 0; BuzzerNormal = 0; Door_Strike = 1;
 }
 if (s == ST_LOCKED) {
  Green_LED = 0; Red_LED = 1; BuzzerNormal = 0; Door_Strike = 0;
 }
 if (s == ST_DENIED) {
  Green_LED = 0; Red_LED = 1; BuzzerNormal = 0; Door_Strike = 0;
  clear_entry();                     // start the reset code entry from empty
 }
}

void main() {
 unsigned char now;
 unsigned char d;
 unsigned char aip;

 ANSELA = 0;
 ANSELB = 0;
 ANSELC = 0;
 CM1CON = 0;
 CM2CON = 0;
 T0CON = 0;
 T2CON = 0;

 OSCCON = 0b01110110;                // 16 MHz internal oscillator

 lata = 0;
 latb = 0;
 latc = 0x00;                        // RC0 low = strike locked from the first instant
 trisa = 0xff;
 trisb = 0x07;
 trisc = 0x00;

 enter_state(ST_IDLE);               // known starting point: locked, entry cleared
 Inittimer();

 while(1){

  // Ticks elapsed since the last pass (8-bit read of cnt is atomic)
  now = cnt;
  d = now - last_cnt;
  last_cnt = now;

  Mapping_IO();

  if (d) {
   debounce_keypad();
   state_ticks += d;
   blink_ticks += d;
   entry_ticks += d;
  }

  // Amber LED and key tone: on only while a key is held
  if (Keypad != 0) { Amber_LED = 1; Buzzer = 1; }
  else             { Amber_LED = 0; Buzzer = 0; }
  Buzzer = 1;    //Testing
  // Flight crew switch (door closed).
  // UNLOCK: opens the door from any state; the 5 s window starts when released.
  // LOCK: door locked, red LED, keypad inhibited for 5 minutes.
  if (FD_UnLock && Closed_Sensor) {
   if (door_state != ST_WINDOW) enter_state(ST_WINDOW);
   state_ticks = 0;
  }
  else if (FD_Lock && Closed_Sensor) {
   if (door_state != ST_DENIED) enter_state(ST_DENIED);
  }

  switch (door_state) {

   case ST_IDLE:
    if (Closed_Sensor == 0) { clear_entry(); break; }   // codes only accepted with door closed

    readkey();
    if (Keypad_Index != last_index) { last_index = Keypad_Index; entry_ticks = 0; }

    if (Keypad_Index > 0) {
     // Checked after every key, so a code without # triggers on its last digit
     if (entry_is(Code_Normal, NORMAL_LEN))       enter_state(ST_NORMAL);
     else if (entry_is(Code_Emerg, EMERG_LEN))    enter_state(ST_EMERG);
     else if (entry_is(Code_Emerg2, EMERG2_LEN))  enter_state(ST_EMERG2);
     else if (Keypad_Array[Keypad_Index - 1] == KEY_HASH ||
              Keypad_Index >= PIN_LEN || entry_ticks >= T_ENTRY) {
      clear_entry();                                // wrong code with #, too long, or abandoned
     }
    }
    break;

   case ST_NORMAL:
    if (blink_ticks >= T_BLINK) { blink_ticks -= T_BLINK; Green_LED = !Green_LED; }
    // No automatic unlock: the door opens only when the flight crew select UNLOCK
    if (state_ticks >= T_NORMAL) enter_state(ST_IDLE);               // no answer: back to idle
    break;

   case ST_EMERG:
    if (blink_ticks >= T_BLINK) { blink_ticks -= T_BLINK; Green_LED = !Green_LED; }
    if (state_ticks >= T_EMERG) enter_state(ST_WINDOW);              // automatic unlock
    break;

   case ST_EMERG2:
    if (blink_ticks >= T_BLINK) { blink_ticks -= T_BLINK; Green_LED = !Green_LED; }
    if (state_ticks >= T_EMERG2) enter_state(ST_WINDOW);             // automatic unlock
    break;

   case ST_WINDOW:
    if (state_ticks >= T_WINDOW) enter_state(ST_LOCKED);
    break;

   case ST_LOCKED:
    if (state_ticks >= T_LOCKED) enter_state(ST_IDLE);
    break;

   case ST_DENIED:
    // Only the reset code is accepted here
    readkey();
    if (Keypad_Index != last_index) { last_index = Keypad_Index; entry_ticks = 0; }
    if (Keypad_Index > 0) {
     if (entry_is(Code_Reset, RESET_LEN)) { enter_state(ST_IDLE); break; }   // lock ended early
     if (Keypad_Array[Keypad_Index - 1] == KEY_HASH ||
         Keypad_Index >= PIN_LEN || entry_ticks >= T_ENTRY) clear_entry();
    }
    if (state_ticks >= T_DENIED) enter_state(ST_IDLE);
    break;
  }

  // Pedestal indicator
  if (door_state == ST_IDLE) {
   if (Closed_Sensor == 0) PedestalOpenInd = 1; else PedestalOpenInd = 0;
  }
  else if (door_state == ST_EMERG || door_state == ST_EMERG2 || door_state == ST_NORMAL) PedestalOpenInd = Green_LED;  // blinks with green
  else if (door_state == ST_WINDOW) PedestalOpenInd = 1;
  else                              PedestalOpenInd = 0;

  // Scenario monitoring (AIP value on Out8..Out11, Out8 = bit 0).
  // Later lines take priority, as in the original table.
  aip = 0;
  if (door_state == ST_NORMAL) aip = 1;
  if (door_state == ST_EMERG || door_state == ST_EMERG2) aip = 2;
  if (door_state == ST_DENIED) aip = 4;
  if (FD_Lock && Closed_Sensor) aip = 5;
  if (door_state == ST_WINDOW) aip = 6;
  if (Closed_Sensor == 0 && (door_state == ST_WINDOW || door_state == ST_IDLE)) aip = 7;
  if (door_state == ST_IDLE && Keypad_Index == 0 && !FD_Lock) aip = 8;

  if (aip & 1) Out8  = 1; else Out8  = 0;
  if (aip & 2) Out9  = 1; else Out9  = 0;
  if (aip & 4) Out10 = 1; else Out10 = 0;
  if (aip & 8) Out11 = 1; else Out11 = 0;
 }
}
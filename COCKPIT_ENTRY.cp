#line 1 "D:/Projects/COCKPIT/COCKPIT_ENTRY.c"
#line 1 "d:/projects/cockpit/mapping.h"

int FD_Lock = 0;
int FD_UnLock = 0;
int Closed_Sensor = 0;
char Keypad = 0;


int Green_LED = 0;
int Red_LED = 0;
int Amber_LED = 0;
int Door_Strike = 0;
int BuzzerNormal = 0;
int Buzzer = 0;
int PedestalOpenInd = 0;
int Out8 = 0;
int Out9 = 0;
int Out10 = 0;
int Out11 = 0;

void Mapping_IO () {

FD_Lock = !porta.f4;
FD_UnLock = !porta.f5;
Closed_Sensor = !portb.f2;


latb.f3 = Green_LED;
latb.f4 = Amber_LED;
latb.f5 = Red_LED;
latc.f0 = Door_Strike;
latc.f1 = BuzzerNormal;
latc.f2 = Buzzer;
latc.f3 = PedestalOpenInd;
latc.f4 = Out8;
latc.f5 = Out9;
latc.f6 = Out10;
latc.f7 = Out11;
}
#line 1 "d:/projects/cockpit/tmr01.h"



volatile unsigned char cnt = 0;

void Inittimer() {
 T1CON = 0b00110111;
 IPR1.TMR1IP = 0;
 IPR1.RC1IP = 1;
 IPR1.TX1IP = 1;
 TMR1IF_bit = 0;
 TMR1H = 0xFC;
 TMR1L = 0x00;
 TMR1IE_bit = 1;
 RCON.IPEN = 1;
 INTCON.GIEH = 1;
 INTCON.GIEL = 1;
 INTCON.TMR0IE = 0;
 INTCON.INT0IE = 0;
 INTCON.RBIE = 0;
 INTCON.TMR0IF = 0;
 INTCON.INT0IF = 0;
 INTCON.RBIF = 0;
}

void dialtone_interrupt() iv 0x0018 ics ICS_AUTO {
 if (TMR1IF_bit){
 TMR1IF_bit = 0;
 TMR1H = 0xFC;
 TMR1L = 0x00;
 cnt++;
 }
}
#line 1 "d:/projects/cockpit/keypad.h"








char Keypad_Array[ 10 ];
unsigned char Keypad_Index = 0;
unsigned char click = 0;



void debounce_keypad() {
 static unsigned char last = 0;
 static unsigned char stable = 0;
 unsigned char raw;

 raw = (~PORTA) & 0x0F;
 if (raw != last) { last = raw; stable = 0; }
 else if (stable <  10 ) { stable++; }
 else { Keypad = raw; }
}



void readkey() {
 if (Keypad == 0) { click = 0; return; }
 if (click) return;
 click = 1;
 if (Keypad > 12) return;
 if (Keypad_Index <  10 ) {
 Keypad_Array[Keypad_Index] = Keypad;
 Keypad_Index++;
 }
}

void clear_entry() {
 unsigned char i;
 for (i = 0; i <  10 ; i++) Keypad_Array[i] = 0;
 Keypad_Index = 0;
}


char entry_is(char *c, unsigned char len) {
 unsigned char i;
 if (Keypad_Index != len) return 0;
 for (i = 0; i < len; i++) {
 if (Keypad_Array[i] != c[i]) return 0;
 }
 return 1;
}
#line 12 "D:/Projects/COCKPIT/COCKPIT_ENTRY.c"
char Code_Normal[ 5 ] = { 10 ,  10 ,  10 ,  10 ,  12 };


char Code_Emerg[ 5 ] = {1, 2, 3, 4,  12 };


char Code_Emerg2[ 3 ] = {1, 2, 3};



char Code_Reset[ 5 ] = { 11 , 9, 9, 9,  12 };
#line 43 "D:/Projects/COCKPIT/COCKPIT_ENTRY.c"
unsigned char door_state =  0 ;
unsigned long state_ticks = 0;
unsigned int blink_ticks = 0;
unsigned int entry_ticks = 0;
unsigned char last_cnt = 0;
unsigned char last_index = 0;




void enter_state(unsigned char s) {
 door_state = s;
 state_ticks = 0;
 blink_ticks = 0;

 if (s ==  0 ) {
 Green_LED = 0; Red_LED = 0; BuzzerNormal = 0; Door_Strike = 0;
 clear_entry();
 }
 if (s ==  1 ) {
 Green_LED = 1; Red_LED = 0; BuzzerNormal = 1; Door_Strike = 0;
 }
 if (s ==  2  || s ==  6 ) {
 Green_LED = 1; Red_LED = 0; BuzzerNormal = 1; Door_Strike = 0;
 }
 if (s ==  3 ) {
 Green_LED = 1; Red_LED = 0; BuzzerNormal = 0; Door_Strike = 1;
 }
 if (s ==  4 ) {
 Green_LED = 0; Red_LED = 1; BuzzerNormal = 0; Door_Strike = 0;
 }
 if (s ==  5 ) {
 Green_LED = 0; Red_LED = 1; BuzzerNormal = 0; Door_Strike = 0;
 clear_entry();
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

 OSCCON = 0b01110110;

 lata = 0;
 latb = 0;
 latc = 0x00;
 trisa = 0xff;
 trisb = 0x07;
 trisc = 0x00;

 enter_state( 0 );
 Inittimer();

 while(1){


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


 if (Keypad != 0) { Amber_LED = 1; Buzzer = 1; }
 else { Amber_LED = 0; Buzzer = 0; }




 if (FD_UnLock && Closed_Sensor) {
 if (door_state !=  3 ) enter_state( 3 );
 state_ticks = 0;
 }
 else if (FD_Lock && Closed_Sensor) {
 if (door_state !=  5 ) enter_state( 5 );
 }

 switch (door_state) {

 case  0 :
 if (Closed_Sensor == 0) { clear_entry(); break; }

 readkey();
 if (Keypad_Index != last_index) { last_index = Keypad_Index; entry_ticks = 0; }

 if (Keypad_Index > 0) {

 if (entry_is(Code_Normal,  5 )) enter_state( 1 );
 else if (entry_is(Code_Emerg,  5 )) enter_state( 2 );
 else if (entry_is(Code_Emerg2,  3 )) enter_state( 6 );
 else if (Keypad_Array[Keypad_Index - 1] ==  12  ||
 Keypad_Index >=  10  || entry_ticks >=  4883 ) {
 clear_entry();
 }
 }
 break;

 case  1 :
 if (blink_ticks >=  244 ) { blink_ticks -=  244 ; Green_LED = !Green_LED; }

 if (state_ticks >=  4883 ) enter_state( 0 );
 break;

 case  2 :
 if (blink_ticks >=  244 ) { blink_ticks -=  244 ; Green_LED = !Green_LED; }
 if (state_ticks >=  4883 ) enter_state( 3 );
 break;

 case  6 :
 if (blink_ticks >=  244 ) { blink_ticks -=  244 ; Green_LED = !Green_LED; }
 if (state_ticks >=  14648 ) enter_state( 3 );
 break;

 case  3 :
 if (state_ticks >=  2441 ) enter_state( 4 );
 break;

 case  4 :
 if (state_ticks >=  1465 ) enter_state( 0 );
 break;

 case  5 :

 readkey();
 if (Keypad_Index != last_index) { last_index = Keypad_Index; entry_ticks = 0; }
 if (Keypad_Index > 0) {
 if (entry_is(Code_Reset,  5 )) { enter_state( 0 ); break; }
 if (Keypad_Array[Keypad_Index - 1] ==  12  ||
 Keypad_Index >=  10  || entry_ticks >=  4883 ) clear_entry();
 }
 if (state_ticks >=  146484 ) enter_state( 0 );
 break;
 }


 if (door_state ==  0 ) {
 if (Closed_Sensor == 0) PedestalOpenInd = 1; else PedestalOpenInd = 0;
 }
 else if (door_state ==  2  || door_state ==  6  || door_state ==  1 ) PedestalOpenInd = Green_LED;
 else if (door_state ==  3 ) PedestalOpenInd = 1;
 else PedestalOpenInd = 0;



 aip = 0;
 if (door_state ==  1 ) aip = 1;
 if (door_state ==  2  || door_state ==  6 ) aip = 2;
 if (door_state ==  5 ) aip = 4;
 if (FD_Lock && Closed_Sensor) aip = 5;
 if (door_state ==  3 ) aip = 6;
 if (Closed_Sensor == 0 && (door_state ==  3  || door_state ==  0 )) aip = 7;
 if (door_state ==  0  && Keypad_Index == 0 && !FD_Lock) aip = 8;

 if (aip & 1) Out8 = 1; else Out8 = 0;
 if (aip & 2) Out9 = 1; else Out9 = 0;
 if (aip & 4) Out10 = 1; else Out10 = 0;
 if (aip & 8) Out11 = 1; else Out11 = 0;
 }
}

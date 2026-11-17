#define PIN_LEN        10
#define DEBOUNCE_TICKS 10            // 10 x 2.048 ms = ~20 ms

// Key values sent by the keypad (1..9 are the digits themselves)
#define KEY_0          10
#define KEY_STAR       11
#define KEY_HASH       12            // also acts as ENT

char Keypad_Array[PIN_LEN];
unsigned char Keypad_Index = 0;
unsigned char click = 0;

// Call once per timer tick. Updates Keypad only after the four lines
// have read the same value for DEBOUNCE_TICKS consecutive ticks.
void debounce_keypad() {
 static unsigned char last = 0;
 static unsigned char stable = 0;
 unsigned char raw;

 raw = (~PORTA) & 0x0F;              // all four lines in one read
 if (raw != last)                  { last = raw; stable = 0; }
 else if (stable < DEBOUNCE_TICKS) { stable++; }
 else                              { Keypad = raw; }
}

// Stores one entry per key press (all twelve keys).
// Never writes past the end of the buffer.
void readkey() {
 if (Keypad == 0) { click = 0; return; }
 if (click) return;
 click = 1;
 if (Keypad > 12) return;
 if (Keypad_Index < PIN_LEN) {
  Keypad_Array[Keypad_Index] = Keypad;
  Keypad_Index++;
 }
}

void clear_entry() {
 unsigned char i;
 for (i = 0; i < PIN_LEN; i++) Keypad_Array[i] = 0;
 Keypad_Index = 0;
}

// True when the entry is exactly the given code (same keys, same length)
char entry_is(char *c, unsigned char len) {
 unsigned char i;
 if (Keypad_Index != len) return 0;
 for (i = 0; i < len; i++) {
  if (Keypad_Array[i] != c[i]) return 0;
 }
 return 1;
}

   // INPUT
int FD_Lock = 0;
int FD_UnLock = 0;
int Closed_Sensor = 0;
char Keypad = 0;              // debounced key code, written by debounce_keypad()

// OUTPUT
int Green_LED = 0;
int Red_LED = 0;
int Amber_LED = 0;
int Door_Strike = 0;          // 0 = locked (default), 1 = open
int BuzzerNormal = 0;
int Buzzer = 0;
int PedestalOpenInd = 0;
int Out8 = 0;
int Out9 = 0;
int Out10 = 0;
int Out11 = 0;

void Mapping_IO () {
//INPUT (keypad lines RA0..RA3 are read in debounce_keypad)
FD_Lock                  = !porta.f4;
FD_UnLock                = !porta.f5;
Closed_Sensor            = !portb.f2;

//OUTPUT (written to the latch, not the port, to avoid read-modify-write errors)
latb.f3                  = Green_LED;
latb.f4                  = Amber_LED;
latb.f5                  = Red_LED;
latc.f0                  = Door_Strike;      // RC0 low = locked, high = open
latc.f1                  = BuzzerNormal;
latc.f2                  = Buzzer;
latc.f3                  = PedestalOpenInd;
latc.f4                  = Out8;
latc.f5                  = Out9;
latc.f6                  = Out10;
latc.f7                  = Out11;
}

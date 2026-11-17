
_Mapping_IO:

;mapping.h,20 :: 		void Mapping_IO () {
;mapping.h,22 :: 		FD_Lock                  = !porta.f4;
	BTFSC       PORTA+0, 4 
	GOTO        L__Mapping_IO122
	BSF         STATUS+0, 0 
	GOTO        L__Mapping_IO123
L__Mapping_IO122:
	BCF         STATUS+0, 0 
L__Mapping_IO123:
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       _FD_Lock+0 
	CLRF        _FD_Lock+1 
;mapping.h,23 :: 		FD_UnLock                = !porta.f5;
	BTFSC       PORTA+0, 5 
	GOTO        L__Mapping_IO124
	BSF         STATUS+0, 0 
	GOTO        L__Mapping_IO125
L__Mapping_IO124:
	BCF         STATUS+0, 0 
L__Mapping_IO125:
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       _FD_UnLock+0 
	CLRF        _FD_UnLock+1 
;mapping.h,24 :: 		Closed_Sensor            = !portb.f2;
	BTFSC       PORTB+0, 2 
	GOTO        L__Mapping_IO126
	BSF         STATUS+0, 0 
	GOTO        L__Mapping_IO127
L__Mapping_IO126:
	BCF         STATUS+0, 0 
L__Mapping_IO127:
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       _Closed_Sensor+0 
	CLRF        _Closed_Sensor+1 
;mapping.h,27 :: 		latb.f3                  = Green_LED;
	BTFSC       _Green_LED+0, 0 
	GOTO        L__Mapping_IO128
	BCF         LATB+0, 3 
	GOTO        L__Mapping_IO129
L__Mapping_IO128:
	BSF         LATB+0, 3 
L__Mapping_IO129:
;mapping.h,28 :: 		latb.f4                  = Amber_LED;
	BTFSC       _Amber_LED+0, 0 
	GOTO        L__Mapping_IO130
	BCF         LATB+0, 4 
	GOTO        L__Mapping_IO131
L__Mapping_IO130:
	BSF         LATB+0, 4 
L__Mapping_IO131:
;mapping.h,29 :: 		latb.f5                  = Red_LED;
	BTFSC       _Red_LED+0, 0 
	GOTO        L__Mapping_IO132
	BCF         LATB+0, 5 
	GOTO        L__Mapping_IO133
L__Mapping_IO132:
	BSF         LATB+0, 5 
L__Mapping_IO133:
;mapping.h,30 :: 		latc.f0                  = Door_Strike;      // RC0 low = locked, high = open
	BTFSC       _Door_Strike+0, 0 
	GOTO        L__Mapping_IO134
	BCF         LATC+0, 0 
	GOTO        L__Mapping_IO135
L__Mapping_IO134:
	BSF         LATC+0, 0 
L__Mapping_IO135:
;mapping.h,31 :: 		latc.f1                  = BuzzerNormal;
	BTFSC       _BuzzerNormal+0, 0 
	GOTO        L__Mapping_IO136
	BCF         LATC+0, 1 
	GOTO        L__Mapping_IO137
L__Mapping_IO136:
	BSF         LATC+0, 1 
L__Mapping_IO137:
;mapping.h,32 :: 		latc.f2                  = Buzzer;
	BTFSC       _Buzzer+0, 0 
	GOTO        L__Mapping_IO138
	BCF         LATC+0, 2 
	GOTO        L__Mapping_IO139
L__Mapping_IO138:
	BSF         LATC+0, 2 
L__Mapping_IO139:
;mapping.h,33 :: 		latc.f3                  = PedestalOpenInd;
	BTFSC       _PedestalOpenInd+0, 0 
	GOTO        L__Mapping_IO140
	BCF         LATC+0, 3 
	GOTO        L__Mapping_IO141
L__Mapping_IO140:
	BSF         LATC+0, 3 
L__Mapping_IO141:
;mapping.h,34 :: 		latc.f4                  = Out8;
	BTFSC       _Out8+0, 0 
	GOTO        L__Mapping_IO142
	BCF         LATC+0, 4 
	GOTO        L__Mapping_IO143
L__Mapping_IO142:
	BSF         LATC+0, 4 
L__Mapping_IO143:
;mapping.h,35 :: 		latc.f5                  = Out9;
	BTFSC       _Out9+0, 0 
	GOTO        L__Mapping_IO144
	BCF         LATC+0, 5 
	GOTO        L__Mapping_IO145
L__Mapping_IO144:
	BSF         LATC+0, 5 
L__Mapping_IO145:
;mapping.h,36 :: 		latc.f6                  = Out10;
	BTFSC       _Out10+0, 0 
	GOTO        L__Mapping_IO146
	BCF         LATC+0, 6 
	GOTO        L__Mapping_IO147
L__Mapping_IO146:
	BSF         LATC+0, 6 
L__Mapping_IO147:
;mapping.h,37 :: 		latc.f7                  = Out11;
	BTFSC       _Out11+0, 0 
	GOTO        L__Mapping_IO148
	BCF         LATC+0, 7 
	GOTO        L__Mapping_IO149
L__Mapping_IO148:
	BSF         LATC+0, 7 
L__Mapping_IO149:
;mapping.h,38 :: 		}
L_end_Mapping_IO:
	RETURN      0
; end of _Mapping_IO

_Inittimer:

;tmr01.h,6 :: 		void Inittimer() {
;tmr01.h,7 :: 		T1CON          = 0b00110111;      // Fosc/4, prescale 1:8, 16-bit read/write, timer on
	MOVLW       55
	MOVWF       T1CON+0 
;tmr01.h,8 :: 		IPR1.TMR1IP    = 0;               // TMR1 low priority
	BCF         IPR1+0, 0 
;tmr01.h,9 :: 		IPR1.RC1IP     = 1;
	BSF         IPR1+0, 5 
;tmr01.h,10 :: 		IPR1.TX1IP     = 1;
	BSF         IPR1+0, 4 
;tmr01.h,11 :: 		TMR1IF_bit     = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;tmr01.h,12 :: 		TMR1H          = 0xFC;
	MOVLW       252
	MOVWF       TMR1H+0 
;tmr01.h,13 :: 		TMR1L          = 0x00;
	CLRF        TMR1L+0 
;tmr01.h,14 :: 		TMR1IE_bit     = 1;
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;tmr01.h,15 :: 		RCON.IPEN      = 1;
	BSF         RCON+0, 7 
;tmr01.h,16 :: 		INTCON.GIEH    = 1;
	BSF         INTCON+0, 7 
;tmr01.h,17 :: 		INTCON.GIEL    = 1;
	BSF         INTCON+0, 6 
;tmr01.h,18 :: 		INTCON.TMR0IE  = 0;
	BCF         INTCON+0, 5 
;tmr01.h,19 :: 		INTCON.INT0IE  = 0;
	BCF         INTCON+0, 4 
;tmr01.h,20 :: 		INTCON.RBIE    = 0;
	BCF         INTCON+0, 3 
;tmr01.h,21 :: 		INTCON.TMR0IF  = 0;
	BCF         INTCON+0, 2 
;tmr01.h,22 :: 		INTCON.INT0IF  = 0;
	BCF         INTCON+0, 1 
;tmr01.h,23 :: 		INTCON.RBIF    = 0;
	BCF         INTCON+0, 0 
;tmr01.h,24 :: 		}
L_end_Inittimer:
	RETURN      0
; end of _Inittimer

_dialtone_interrupt:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;tmr01.h,26 :: 		void dialtone_interrupt() iv 0x0018 ics ICS_AUTO {
;tmr01.h,27 :: 		if (TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
	GOTO        L_dialtone_interrupt0
;tmr01.h,28 :: 		TMR1IF_bit = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;tmr01.h,29 :: 		TMR1H = 0xFC;
	MOVLW       252
	MOVWF       TMR1H+0 
;tmr01.h,30 :: 		TMR1L = 0x00;
	CLRF        TMR1L+0 
;tmr01.h,31 :: 		cnt++;
	MOVF        _cnt+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _cnt+0 
;tmr01.h,32 :: 		}
L_dialtone_interrupt0:
;tmr01.h,33 :: 		}
L_end_dialtone_interrupt:
L__dialtone_interrupt152:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _dialtone_interrupt

_debounce_keypad:

;keypad.h,15 :: 		void debounce_keypad() {
;keypad.h,20 :: 		raw = (~PORTA) & 0x0F;              // all four lines in one read
	COMF        PORTA+0, 0 
	MOVWF       R0 
	MOVLW       15
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R2 
;keypad.h,21 :: 		if (raw != last)                  { last = raw; stable = 0; }
	MOVF        R1, 0 
	XORWF       debounce_keypad_last_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_debounce_keypad1
	MOVF        R2, 0 
	MOVWF       debounce_keypad_last_L0+0 
	CLRF        debounce_keypad_stable_L0+0 
	GOTO        L_debounce_keypad2
L_debounce_keypad1:
;keypad.h,22 :: 		else if (stable < DEBOUNCE_TICKS) { stable++; }
	MOVLW       10
	SUBWF       debounce_keypad_stable_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_debounce_keypad3
	INCF        debounce_keypad_stable_L0+0, 1 
	GOTO        L_debounce_keypad4
L_debounce_keypad3:
;keypad.h,23 :: 		else                              { Keypad = raw; }
	MOVF        R2, 0 
	MOVWF       _Keypad+0 
L_debounce_keypad4:
L_debounce_keypad2:
;keypad.h,24 :: 		}
L_end_debounce_keypad:
	RETURN      0
; end of _debounce_keypad

_readkey:

;keypad.h,28 :: 		void readkey() {
;keypad.h,29 :: 		if (Keypad == 0) { click = 0; return; }
	MOVF        _Keypad+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_readkey5
	CLRF        _click+0 
	GOTO        L_end_readkey
L_readkey5:
;keypad.h,30 :: 		if (click) return;
	MOVF        _click+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_readkey6
	GOTO        L_end_readkey
L_readkey6:
;keypad.h,31 :: 		click = 1;
	MOVLW       1
	MOVWF       _click+0 
;keypad.h,32 :: 		if (Keypad > 12) return;
	MOVF        _Keypad+0, 0 
	SUBLW       12
	BTFSC       STATUS+0, 0 
	GOTO        L_readkey7
	GOTO        L_end_readkey
L_readkey7:
;keypad.h,33 :: 		if (Keypad_Index < PIN_LEN) {
	MOVLW       10
	SUBWF       _Keypad_Index+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_readkey8
;keypad.h,34 :: 		Keypad_Array[Keypad_Index] = Keypad;
	MOVLW       _Keypad_Array+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_Keypad_Array+0)
	MOVWF       FSR1L+1 
	MOVF        _Keypad_Index+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVF        _Keypad+0, 0 
	MOVWF       POSTINC1+0 
;keypad.h,35 :: 		Keypad_Index++;
	INCF        _Keypad_Index+0, 1 
;keypad.h,36 :: 		}
L_readkey8:
;keypad.h,37 :: 		}
L_end_readkey:
	RETURN      0
; end of _readkey

_clear_entry:

;keypad.h,39 :: 		void clear_entry() {
;keypad.h,41 :: 		for (i = 0; i < PIN_LEN; i++) Keypad_Array[i] = 0;
	CLRF        R1 
L_clear_entry9:
	MOVLW       10
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_clear_entry10
	MOVLW       _Keypad_Array+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_Keypad_Array+0)
	MOVWF       FSR1L+1 
	MOVF        R1, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	CLRF        POSTINC1+0 
	INCF        R1, 1 
	GOTO        L_clear_entry9
L_clear_entry10:
;keypad.h,42 :: 		Keypad_Index = 0;
	CLRF        _Keypad_Index+0 
;keypad.h,43 :: 		}
L_end_clear_entry:
	RETURN      0
; end of _clear_entry

_entry_is:

;keypad.h,46 :: 		char entry_is(char *c, unsigned char len) {
;keypad.h,48 :: 		if (Keypad_Index != len) return 0;
	MOVF        _Keypad_Index+0, 0 
	XORWF       FARG_entry_is_len+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_entry_is12
	CLRF        R0 
	GOTO        L_end_entry_is
L_entry_is12:
;keypad.h,49 :: 		for (i = 0; i < len; i++) {
	CLRF        R1 
L_entry_is13:
	MOVF        FARG_entry_is_len+0, 0 
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_entry_is14
;keypad.h,50 :: 		if (Keypad_Array[i] != c[i]) return 0;
	MOVLW       _Keypad_Array+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_Keypad_Array+0)
	MOVWF       FSR0L+1 
	MOVF        R1, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        R1, 0 
	ADDWF       FARG_entry_is_c+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_entry_is_c+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_entry_is16
	CLRF        R0 
	GOTO        L_end_entry_is
L_entry_is16:
;keypad.h,49 :: 		for (i = 0; i < len; i++) {
	INCF        R1, 1 
;keypad.h,51 :: 		}
	GOTO        L_entry_is13
L_entry_is14:
;keypad.h,52 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;keypad.h,53 :: 		}
L_end_entry_is:
	RETURN      0
; end of _entry_is

_enter_state:

;COCKPIT_ENTRY.c,53 :: 		void enter_state(unsigned char s) {
;COCKPIT_ENTRY.c,54 :: 		door_state  = s;
	MOVF        FARG_enter_state_s+0, 0 
	MOVWF       _door_state+0 
;COCKPIT_ENTRY.c,55 :: 		state_ticks = 0;
	CLRF        _state_ticks+0 
	CLRF        _state_ticks+1 
	CLRF        _state_ticks+2 
	CLRF        _state_ticks+3 
;COCKPIT_ENTRY.c,56 :: 		blink_ticks = 0;
	CLRF        _blink_ticks+0 
	CLRF        _blink_ticks+1 
;COCKPIT_ENTRY.c,58 :: 		if (s == ST_IDLE) {
	MOVF        FARG_enter_state_s+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_enter_state17
;COCKPIT_ENTRY.c,59 :: 		Green_LED = 0; Red_LED = 0; BuzzerNormal = 0; Door_Strike = 0;
	CLRF        _Green_LED+0 
	CLRF        _Green_LED+1 
	CLRF        _Red_LED+0 
	CLRF        _Red_LED+1 
	CLRF        _BuzzerNormal+0 
	CLRF        _BuzzerNormal+1 
	CLRF        _Door_Strike+0 
	CLRF        _Door_Strike+1 
;COCKPIT_ENTRY.c,60 :: 		clear_entry();
	CALL        _clear_entry+0, 0
;COCKPIT_ENTRY.c,61 :: 		}
L_enter_state17:
;COCKPIT_ENTRY.c,62 :: 		if (s == ST_NORMAL) {
	MOVF        FARG_enter_state_s+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_enter_state18
;COCKPIT_ENTRY.c,63 :: 		Green_LED = 1; Red_LED = 0; BuzzerNormal = 1; Door_Strike = 0;
	MOVLW       1
	MOVWF       _Green_LED+0 
	MOVLW       0
	MOVWF       _Green_LED+1 
	CLRF        _Red_LED+0 
	CLRF        _Red_LED+1 
	MOVLW       1
	MOVWF       _BuzzerNormal+0 
	MOVLW       0
	MOVWF       _BuzzerNormal+1 
	CLRF        _Door_Strike+0 
	CLRF        _Door_Strike+1 
;COCKPIT_ENTRY.c,64 :: 		}
L_enter_state18:
;COCKPIT_ENTRY.c,65 :: 		if (s == ST_EMERG || s == ST_EMERG2) {
	MOVF        FARG_enter_state_s+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__enter_state110
	MOVF        FARG_enter_state_s+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__enter_state110
	GOTO        L_enter_state21
L__enter_state110:
;COCKPIT_ENTRY.c,66 :: 		Green_LED = 1; Red_LED = 0; BuzzerNormal = 1; Door_Strike = 0;
	MOVLW       1
	MOVWF       _Green_LED+0 
	MOVLW       0
	MOVWF       _Green_LED+1 
	CLRF        _Red_LED+0 
	CLRF        _Red_LED+1 
	MOVLW       1
	MOVWF       _BuzzerNormal+0 
	MOVLW       0
	MOVWF       _BuzzerNormal+1 
	CLRF        _Door_Strike+0 
	CLRF        _Door_Strike+1 
;COCKPIT_ENTRY.c,67 :: 		}
L_enter_state21:
;COCKPIT_ENTRY.c,68 :: 		if (s == ST_WINDOW) {
	MOVF        FARG_enter_state_s+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_enter_state22
;COCKPIT_ENTRY.c,69 :: 		Green_LED = 1; Red_LED = 0; BuzzerNormal = 0; Door_Strike = 1;
	MOVLW       1
	MOVWF       _Green_LED+0 
	MOVLW       0
	MOVWF       _Green_LED+1 
	CLRF        _Red_LED+0 
	CLRF        _Red_LED+1 
	CLRF        _BuzzerNormal+0 
	CLRF        _BuzzerNormal+1 
	MOVLW       1
	MOVWF       _Door_Strike+0 
	MOVLW       0
	MOVWF       _Door_Strike+1 
;COCKPIT_ENTRY.c,70 :: 		}
L_enter_state22:
;COCKPIT_ENTRY.c,71 :: 		if (s == ST_LOCKED) {
	MOVF        FARG_enter_state_s+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_enter_state23
;COCKPIT_ENTRY.c,72 :: 		Green_LED = 0; Red_LED = 1; BuzzerNormal = 0; Door_Strike = 0;
	CLRF        _Green_LED+0 
	CLRF        _Green_LED+1 
	MOVLW       1
	MOVWF       _Red_LED+0 
	MOVLW       0
	MOVWF       _Red_LED+1 
	CLRF        _BuzzerNormal+0 
	CLRF        _BuzzerNormal+1 
	CLRF        _Door_Strike+0 
	CLRF        _Door_Strike+1 
;COCKPIT_ENTRY.c,73 :: 		}
L_enter_state23:
;COCKPIT_ENTRY.c,74 :: 		if (s == ST_DENIED) {
	MOVF        FARG_enter_state_s+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_enter_state24
;COCKPIT_ENTRY.c,75 :: 		Green_LED = 0; Red_LED = 1; BuzzerNormal = 0; Door_Strike = 0;
	CLRF        _Green_LED+0 
	CLRF        _Green_LED+1 
	MOVLW       1
	MOVWF       _Red_LED+0 
	MOVLW       0
	MOVWF       _Red_LED+1 
	CLRF        _BuzzerNormal+0 
	CLRF        _BuzzerNormal+1 
	CLRF        _Door_Strike+0 
	CLRF        _Door_Strike+1 
;COCKPIT_ENTRY.c,76 :: 		clear_entry();                     // start the reset code entry from empty
	CALL        _clear_entry+0, 0
;COCKPIT_ENTRY.c,77 :: 		}
L_enter_state24:
;COCKPIT_ENTRY.c,78 :: 		}
L_end_enter_state:
	RETURN      0
; end of _enter_state

_main:

;COCKPIT_ENTRY.c,80 :: 		void main() {
;COCKPIT_ENTRY.c,85 :: 		ANSELA = 0;
	CLRF        ANSELA+0 
;COCKPIT_ENTRY.c,86 :: 		ANSELB = 0;
	CLRF        ANSELB+0 
;COCKPIT_ENTRY.c,87 :: 		ANSELC = 0;
	CLRF        ANSELC+0 
;COCKPIT_ENTRY.c,88 :: 		CM1CON = 0;
	CLRF        CM1CON+0 
;COCKPIT_ENTRY.c,89 :: 		CM2CON = 0;
	CLRF        CM2CON+0 
;COCKPIT_ENTRY.c,90 :: 		T0CON = 0;
	CLRF        T0CON+0 
;COCKPIT_ENTRY.c,91 :: 		T2CON = 0;
	CLRF        T2CON+0 
;COCKPIT_ENTRY.c,93 :: 		OSCCON = 0b01110110;                // 16 MHz internal oscillator
	MOVLW       118
	MOVWF       OSCCON+0 
;COCKPIT_ENTRY.c,95 :: 		lata = 0;
	CLRF        LATA+0 
;COCKPIT_ENTRY.c,96 :: 		latb = 0;
	CLRF        LATB+0 
;COCKPIT_ENTRY.c,97 :: 		latc = 0x00;                        // RC0 low = strike locked from the first instant
	CLRF        LATC+0 
;COCKPIT_ENTRY.c,98 :: 		trisa = 0xff;
	MOVLW       255
	MOVWF       TRISA+0 
;COCKPIT_ENTRY.c,99 :: 		trisb = 0x07;
	MOVLW       7
	MOVWF       TRISB+0 
;COCKPIT_ENTRY.c,100 :: 		trisc = 0x00;
	CLRF        TRISC+0 
;COCKPIT_ENTRY.c,102 :: 		enter_state(ST_IDLE);               // known starting point: locked, entry cleared
	CLRF        FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
;COCKPIT_ENTRY.c,103 :: 		Inittimer();
	CALL        _Inittimer+0, 0
;COCKPIT_ENTRY.c,105 :: 		while(1){
L_main25:
;COCKPIT_ENTRY.c,108 :: 		now = cnt;
	MOVF        _cnt+0, 0 
	MOVWF       main_now_L0+0 
;COCKPIT_ENTRY.c,109 :: 		d = now - last_cnt;
	MOVF        _last_cnt+0, 0 
	SUBWF       main_now_L0+0, 0 
	MOVWF       main_d_L0+0 
;COCKPIT_ENTRY.c,110 :: 		last_cnt = now;
	MOVF        main_now_L0+0, 0 
	MOVWF       _last_cnt+0 
;COCKPIT_ENTRY.c,112 :: 		Mapping_IO();
	CALL        _Mapping_IO+0, 0
;COCKPIT_ENTRY.c,114 :: 		if (d) {
	MOVF        main_d_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
;COCKPIT_ENTRY.c,115 :: 		debounce_keypad();
	CALL        _debounce_keypad+0, 0
;COCKPIT_ENTRY.c,116 :: 		state_ticks += d;
	MOVF        main_d_L0+0, 0 
	ADDWF       _state_ticks+0, 1 
	MOVLW       0
	ADDWFC      _state_ticks+1, 1 
	ADDWFC      _state_ticks+2, 1 
	ADDWFC      _state_ticks+3, 1 
;COCKPIT_ENTRY.c,117 :: 		blink_ticks += d;
	MOVF        main_d_L0+0, 0 
	ADDWF       _blink_ticks+0, 1 
	MOVLW       0
	ADDWFC      _blink_ticks+1, 1 
;COCKPIT_ENTRY.c,118 :: 		entry_ticks += d;
	MOVF        main_d_L0+0, 0 
	ADDWF       _entry_ticks+0, 1 
	MOVLW       0
	ADDWFC      _entry_ticks+1, 1 
;COCKPIT_ENTRY.c,119 :: 		}
L_main27:
;COCKPIT_ENTRY.c,122 :: 		if (Keypad != 0) { Amber_LED = 1; Buzzer = 1; }
	MOVF        _Keypad+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main28
	MOVLW       1
	MOVWF       _Amber_LED+0 
	MOVLW       0
	MOVWF       _Amber_LED+1 
	MOVLW       1
	MOVWF       _Buzzer+0 
	MOVLW       0
	MOVWF       _Buzzer+1 
	GOTO        L_main29
L_main28:
;COCKPIT_ENTRY.c,123 :: 		else             { Amber_LED = 0; Buzzer = 0; }
	CLRF        _Amber_LED+0 
	CLRF        _Amber_LED+1 
	CLRF        _Buzzer+0 
	CLRF        _Buzzer+1 
L_main29:
;COCKPIT_ENTRY.c,128 :: 		if (FD_UnLock && Closed_Sensor) {
	MOVF        _FD_UnLock+0, 0 
	IORWF       _FD_UnLock+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main32
	MOVF        _Closed_Sensor+0, 0 
	IORWF       _Closed_Sensor+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main32
L__main120:
;COCKPIT_ENTRY.c,129 :: 		if (door_state != ST_WINDOW) enter_state(ST_WINDOW);
	MOVF        _door_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main33
	MOVLW       3
	MOVWF       FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
L_main33:
;COCKPIT_ENTRY.c,130 :: 		state_ticks = 0;
	CLRF        _state_ticks+0 
	CLRF        _state_ticks+1 
	CLRF        _state_ticks+2 
	CLRF        _state_ticks+3 
;COCKPIT_ENTRY.c,131 :: 		}
	GOTO        L_main34
L_main32:
;COCKPIT_ENTRY.c,132 :: 		else if (FD_Lock && Closed_Sensor) {
	MOVF        _FD_Lock+0, 0 
	IORWF       _FD_Lock+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main37
	MOVF        _Closed_Sensor+0, 0 
	IORWF       _Closed_Sensor+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main37
L__main119:
;COCKPIT_ENTRY.c,133 :: 		if (door_state != ST_DENIED) enter_state(ST_DENIED);
	MOVF        _door_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main38
	MOVLW       5
	MOVWF       FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
L_main38:
;COCKPIT_ENTRY.c,134 :: 		}
L_main37:
L_main34:
;COCKPIT_ENTRY.c,136 :: 		switch (door_state) {
	GOTO        L_main39
;COCKPIT_ENTRY.c,138 :: 		case ST_IDLE:
L_main41:
;COCKPIT_ENTRY.c,139 :: 		if (Closed_Sensor == 0) { clear_entry(); break; }   // codes only accepted with door closed
	MOVLW       0
	XORWF       _Closed_Sensor+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main159
	MOVLW       0
	XORWF       _Closed_Sensor+0, 0 
L__main159:
	BTFSS       STATUS+0, 2 
	GOTO        L_main42
	CALL        _clear_entry+0, 0
	GOTO        L_main40
L_main42:
;COCKPIT_ENTRY.c,141 :: 		readkey();
	CALL        _readkey+0, 0
;COCKPIT_ENTRY.c,142 :: 		if (Keypad_Index != last_index) { last_index = Keypad_Index; entry_ticks = 0; }
	MOVF        _Keypad_Index+0, 0 
	XORWF       _last_index+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main43
	MOVF        _Keypad_Index+0, 0 
	MOVWF       _last_index+0 
	CLRF        _entry_ticks+0 
	CLRF        _entry_ticks+1 
L_main43:
;COCKPIT_ENTRY.c,144 :: 		if (Keypad_Index > 0) {
	MOVF        _Keypad_Index+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main44
;COCKPIT_ENTRY.c,146 :: 		if (entry_is(Code_Normal, NORMAL_LEN))       enter_state(ST_NORMAL);
	MOVLW       _Code_Normal+0
	MOVWF       FARG_entry_is_c+0 
	MOVLW       hi_addr(_Code_Normal+0)
	MOVWF       FARG_entry_is_c+1 
	MOVLW       5
	MOVWF       FARG_entry_is_len+0 
	CALL        _entry_is+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main45
	MOVLW       1
	MOVWF       FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
	GOTO        L_main46
L_main45:
;COCKPIT_ENTRY.c,147 :: 		else if (entry_is(Code_Emerg, EMERG_LEN))    enter_state(ST_EMERG);
	MOVLW       _Code_Emerg+0
	MOVWF       FARG_entry_is_c+0 
	MOVLW       hi_addr(_Code_Emerg+0)
	MOVWF       FARG_entry_is_c+1 
	MOVLW       5
	MOVWF       FARG_entry_is_len+0 
	CALL        _entry_is+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main47
	MOVLW       2
	MOVWF       FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
	GOTO        L_main48
L_main47:
;COCKPIT_ENTRY.c,148 :: 		else if (entry_is(Code_Emerg2, EMERG2_LEN))  enter_state(ST_EMERG2);
	MOVLW       _Code_Emerg2+0
	MOVWF       FARG_entry_is_c+0 
	MOVLW       hi_addr(_Code_Emerg2+0)
	MOVWF       FARG_entry_is_c+1 
	MOVLW       3
	MOVWF       FARG_entry_is_len+0 
	CALL        _entry_is+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main49
	MOVLW       6
	MOVWF       FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
	GOTO        L_main50
L_main49:
;COCKPIT_ENTRY.c,149 :: 		else if (Keypad_Array[Keypad_Index - 1] == KEY_HASH ||
	DECF        _Keypad_Index+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       _Keypad_Array+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_Keypad_Array+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
;COCKPIT_ENTRY.c,150 :: 		Keypad_Index >= PIN_LEN || entry_ticks >= T_ENTRY) {
	MOVF        POSTINC0+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L__main118
	MOVLW       10
	SUBWF       _Keypad_Index+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__main118
	MOVLW       19
	SUBWF       _entry_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main160
	MOVLW       19
	SUBWF       _entry_ticks+0, 0 
L__main160:
	BTFSC       STATUS+0, 0 
	GOTO        L__main118
	GOTO        L_main53
L__main118:
;COCKPIT_ENTRY.c,151 :: 		clear_entry();                                // wrong code with #, too long, or abandoned
	CALL        _clear_entry+0, 0
;COCKPIT_ENTRY.c,152 :: 		}
L_main53:
L_main50:
L_main48:
L_main46:
;COCKPIT_ENTRY.c,153 :: 		}
L_main44:
;COCKPIT_ENTRY.c,154 :: 		break;
	GOTO        L_main40
;COCKPIT_ENTRY.c,156 :: 		case ST_NORMAL:
L_main54:
;COCKPIT_ENTRY.c,157 :: 		if (blink_ticks >= T_BLINK) { blink_ticks -= T_BLINK; Green_LED = !Green_LED; }
	MOVLW       0
	SUBWF       _blink_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main161
	MOVLW       244
	SUBWF       _blink_ticks+0, 0 
L__main161:
	BTFSS       STATUS+0, 0 
	GOTO        L_main55
	MOVLW       244
	SUBWF       _blink_ticks+0, 1 
	MOVLW       0
	SUBWFB      _blink_ticks+1, 1 
	MOVF        _Green_LED+0, 0 
	IORWF       _Green_LED+1, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _Green_LED+0 
	MOVLW       0
	MOVWF       _Green_LED+1 
L_main55:
;COCKPIT_ENTRY.c,159 :: 		if (state_ticks >= T_NORMAL) enter_state(ST_IDLE);               // no answer: back to idle
	MOVLW       0
	SUBWF       _state_ticks+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main162
	MOVLW       0
	SUBWF       _state_ticks+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main162
	MOVLW       19
	SUBWF       _state_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main162
	MOVLW       19
	SUBWF       _state_ticks+0, 0 
L__main162:
	BTFSS       STATUS+0, 0 
	GOTO        L_main56
	CLRF        FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
L_main56:
;COCKPIT_ENTRY.c,160 :: 		break;
	GOTO        L_main40
;COCKPIT_ENTRY.c,162 :: 		case ST_EMERG:
L_main57:
;COCKPIT_ENTRY.c,163 :: 		if (blink_ticks >= T_BLINK) { blink_ticks -= T_BLINK; Green_LED = !Green_LED; }
	MOVLW       0
	SUBWF       _blink_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main163
	MOVLW       244
	SUBWF       _blink_ticks+0, 0 
L__main163:
	BTFSS       STATUS+0, 0 
	GOTO        L_main58
	MOVLW       244
	SUBWF       _blink_ticks+0, 1 
	MOVLW       0
	SUBWFB      _blink_ticks+1, 1 
	MOVF        _Green_LED+0, 0 
	IORWF       _Green_LED+1, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _Green_LED+0 
	MOVLW       0
	MOVWF       _Green_LED+1 
L_main58:
;COCKPIT_ENTRY.c,164 :: 		if (state_ticks >= T_EMERG) enter_state(ST_WINDOW);              // automatic unlock
	MOVLW       0
	SUBWF       _state_ticks+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main164
	MOVLW       0
	SUBWF       _state_ticks+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main164
	MOVLW       19
	SUBWF       _state_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main164
	MOVLW       19
	SUBWF       _state_ticks+0, 0 
L__main164:
	BTFSS       STATUS+0, 0 
	GOTO        L_main59
	MOVLW       3
	MOVWF       FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
L_main59:
;COCKPIT_ENTRY.c,165 :: 		break;
	GOTO        L_main40
;COCKPIT_ENTRY.c,167 :: 		case ST_EMERG2:
L_main60:
;COCKPIT_ENTRY.c,168 :: 		if (blink_ticks >= T_BLINK) { blink_ticks -= T_BLINK; Green_LED = !Green_LED; }
	MOVLW       0
	SUBWF       _blink_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main165
	MOVLW       244
	SUBWF       _blink_ticks+0, 0 
L__main165:
	BTFSS       STATUS+0, 0 
	GOTO        L_main61
	MOVLW       244
	SUBWF       _blink_ticks+0, 1 
	MOVLW       0
	SUBWFB      _blink_ticks+1, 1 
	MOVF        _Green_LED+0, 0 
	IORWF       _Green_LED+1, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _Green_LED+0 
	MOVLW       0
	MOVWF       _Green_LED+1 
L_main61:
;COCKPIT_ENTRY.c,169 :: 		if (state_ticks >= T_EMERG2) enter_state(ST_WINDOW);             // automatic unlock
	MOVLW       0
	SUBWF       _state_ticks+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main166
	MOVLW       0
	SUBWF       _state_ticks+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main166
	MOVLW       57
	SUBWF       _state_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main166
	MOVLW       56
	SUBWF       _state_ticks+0, 0 
L__main166:
	BTFSS       STATUS+0, 0 
	GOTO        L_main62
	MOVLW       3
	MOVWF       FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
L_main62:
;COCKPIT_ENTRY.c,170 :: 		break;
	GOTO        L_main40
;COCKPIT_ENTRY.c,172 :: 		case ST_WINDOW:
L_main63:
;COCKPIT_ENTRY.c,173 :: 		if (state_ticks >= T_WINDOW) enter_state(ST_LOCKED);
	MOVLW       0
	SUBWF       _state_ticks+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main167
	MOVLW       0
	SUBWF       _state_ticks+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main167
	MOVLW       9
	SUBWF       _state_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main167
	MOVLW       137
	SUBWF       _state_ticks+0, 0 
L__main167:
	BTFSS       STATUS+0, 0 
	GOTO        L_main64
	MOVLW       4
	MOVWF       FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
L_main64:
;COCKPIT_ENTRY.c,174 :: 		break;
	GOTO        L_main40
;COCKPIT_ENTRY.c,176 :: 		case ST_LOCKED:
L_main65:
;COCKPIT_ENTRY.c,177 :: 		if (state_ticks >= T_LOCKED) enter_state(ST_IDLE);
	MOVLW       0
	SUBWF       _state_ticks+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main168
	MOVLW       0
	SUBWF       _state_ticks+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main168
	MOVLW       5
	SUBWF       _state_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main168
	MOVLW       185
	SUBWF       _state_ticks+0, 0 
L__main168:
	BTFSS       STATUS+0, 0 
	GOTO        L_main66
	CLRF        FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
L_main66:
;COCKPIT_ENTRY.c,178 :: 		break;
	GOTO        L_main40
;COCKPIT_ENTRY.c,180 :: 		case ST_DENIED:
L_main67:
;COCKPIT_ENTRY.c,182 :: 		readkey();
	CALL        _readkey+0, 0
;COCKPIT_ENTRY.c,183 :: 		if (Keypad_Index != last_index) { last_index = Keypad_Index; entry_ticks = 0; }
	MOVF        _Keypad_Index+0, 0 
	XORWF       _last_index+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main68
	MOVF        _Keypad_Index+0, 0 
	MOVWF       _last_index+0 
	CLRF        _entry_ticks+0 
	CLRF        _entry_ticks+1 
L_main68:
;COCKPIT_ENTRY.c,184 :: 		if (Keypad_Index > 0) {
	MOVF        _Keypad_Index+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main69
;COCKPIT_ENTRY.c,185 :: 		if (entry_is(Code_Reset, RESET_LEN)) { enter_state(ST_IDLE); break; }   // lock ended early
	MOVLW       _Code_Reset+0
	MOVWF       FARG_entry_is_c+0 
	MOVLW       hi_addr(_Code_Reset+0)
	MOVWF       FARG_entry_is_c+1 
	MOVLW       5
	MOVWF       FARG_entry_is_len+0 
	CALL        _entry_is+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main70
	CLRF        FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
	GOTO        L_main40
L_main70:
;COCKPIT_ENTRY.c,186 :: 		if (Keypad_Array[Keypad_Index - 1] == KEY_HASH ||
	DECF        _Keypad_Index+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       _Keypad_Array+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_Keypad_Array+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
;COCKPIT_ENTRY.c,187 :: 		Keypad_Index >= PIN_LEN || entry_ticks >= T_ENTRY) clear_entry();
	MOVF        POSTINC0+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L__main117
	MOVLW       10
	SUBWF       _Keypad_Index+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__main117
	MOVLW       19
	SUBWF       _entry_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main169
	MOVLW       19
	SUBWF       _entry_ticks+0, 0 
L__main169:
	BTFSC       STATUS+0, 0 
	GOTO        L__main117
	GOTO        L_main73
L__main117:
	CALL        _clear_entry+0, 0
L_main73:
;COCKPIT_ENTRY.c,188 :: 		}
L_main69:
;COCKPIT_ENTRY.c,189 :: 		if (state_ticks >= T_DENIED) enter_state(ST_IDLE);
	MOVLW       0
	SUBWF       _state_ticks+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main170
	MOVLW       2
	SUBWF       _state_ticks+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main170
	MOVLW       60
	SUBWF       _state_ticks+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main170
	MOVLW       52
	SUBWF       _state_ticks+0, 0 
L__main170:
	BTFSS       STATUS+0, 0 
	GOTO        L_main74
	CLRF        FARG_enter_state_s+0 
	CALL        _enter_state+0, 0
L_main74:
;COCKPIT_ENTRY.c,190 :: 		break;
	GOTO        L_main40
;COCKPIT_ENTRY.c,191 :: 		}
L_main39:
	MOVF        _door_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main41
	MOVF        _door_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main54
	MOVF        _door_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
	MOVF        _door_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main60
	MOVF        _door_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main63
	MOVF        _door_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main65
	MOVF        _door_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main67
L_main40:
;COCKPIT_ENTRY.c,194 :: 		if (door_state == ST_IDLE) {
	MOVF        _door_state+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main75
;COCKPIT_ENTRY.c,195 :: 		if (Closed_Sensor == 0) PedestalOpenInd = 1; else PedestalOpenInd = 0;
	MOVLW       0
	XORWF       _Closed_Sensor+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main171
	MOVLW       0
	XORWF       _Closed_Sensor+0, 0 
L__main171:
	BTFSS       STATUS+0, 2 
	GOTO        L_main76
	MOVLW       1
	MOVWF       _PedestalOpenInd+0 
	MOVLW       0
	MOVWF       _PedestalOpenInd+1 
	GOTO        L_main77
L_main76:
	CLRF        _PedestalOpenInd+0 
	CLRF        _PedestalOpenInd+1 
L_main77:
;COCKPIT_ENTRY.c,196 :: 		}
	GOTO        L_main78
L_main75:
;COCKPIT_ENTRY.c,197 :: 		else if (door_state == ST_EMERG || door_state == ST_EMERG2 || door_state == ST_NORMAL) PedestalOpenInd = Green_LED;  // blinks with green
	MOVF        _door_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__main116
	MOVF        _door_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__main116
	MOVF        _door_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__main116
	GOTO        L_main81
L__main116:
	MOVF        _Green_LED+0, 0 
	MOVWF       _PedestalOpenInd+0 
	MOVF        _Green_LED+1, 0 
	MOVWF       _PedestalOpenInd+1 
	GOTO        L_main82
L_main81:
;COCKPIT_ENTRY.c,198 :: 		else if (door_state == ST_WINDOW) PedestalOpenInd = 1;
	MOVF        _door_state+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main83
	MOVLW       1
	MOVWF       _PedestalOpenInd+0 
	MOVLW       0
	MOVWF       _PedestalOpenInd+1 
	GOTO        L_main84
L_main83:
;COCKPIT_ENTRY.c,199 :: 		else                              PedestalOpenInd = 0;
	CLRF        _PedestalOpenInd+0 
	CLRF        _PedestalOpenInd+1 
L_main84:
L_main82:
L_main78:
;COCKPIT_ENTRY.c,203 :: 		aip = 0;
	CLRF        main_aip_L0+0 
;COCKPIT_ENTRY.c,204 :: 		if (door_state == ST_NORMAL) aip = 1;
	MOVF        _door_state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main85
	MOVLW       1
	MOVWF       main_aip_L0+0 
L_main85:
;COCKPIT_ENTRY.c,205 :: 		if (door_state == ST_EMERG || door_state == ST_EMERG2) aip = 2;
	MOVF        _door_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__main115
	MOVF        _door_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__main115
	GOTO        L_main88
L__main115:
	MOVLW       2
	MOVWF       main_aip_L0+0 
L_main88:
;COCKPIT_ENTRY.c,206 :: 		if (door_state == ST_DENIED) aip = 4;
	MOVF        _door_state+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_main89
	MOVLW       4
	MOVWF       main_aip_L0+0 
L_main89:
;COCKPIT_ENTRY.c,207 :: 		if (FD_Lock && Closed_Sensor) aip = 5;
	MOVF        _FD_Lock+0, 0 
	IORWF       _FD_Lock+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main92
	MOVF        _Closed_Sensor+0, 0 
	IORWF       _Closed_Sensor+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main92
L__main114:
	MOVLW       5
	MOVWF       main_aip_L0+0 
L_main92:
;COCKPIT_ENTRY.c,208 :: 		if (door_state == ST_WINDOW) aip = 6;
	MOVF        _door_state+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main93
	MOVLW       6
	MOVWF       main_aip_L0+0 
L_main93:
;COCKPIT_ENTRY.c,209 :: 		if (Closed_Sensor == 0 && (door_state == ST_WINDOW || door_state == ST_IDLE)) aip = 7;
	MOVLW       0
	XORWF       _Closed_Sensor+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main172
	MOVLW       0
	XORWF       _Closed_Sensor+0, 0 
L__main172:
	BTFSS       STATUS+0, 2 
	GOTO        L_main98
	MOVF        _door_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__main113
	MOVF        _door_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__main113
	GOTO        L_main98
L__main113:
L__main112:
	MOVLW       7
	MOVWF       main_aip_L0+0 
L_main98:
;COCKPIT_ENTRY.c,210 :: 		if (door_state == ST_IDLE && Keypad_Index == 0 && !FD_Lock) aip = 8;
	MOVF        _door_state+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main101
	MOVF        _Keypad_Index+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main101
	MOVF        _FD_Lock+0, 0 
	IORWF       _FD_Lock+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main101
L__main111:
	MOVLW       8
	MOVWF       main_aip_L0+0 
L_main101:
;COCKPIT_ENTRY.c,212 :: 		if (aip & 1) Out8  = 1; else Out8  = 0;
	BTFSS       main_aip_L0+0, 0 
	GOTO        L_main102
	MOVLW       1
	MOVWF       _Out8+0 
	MOVLW       0
	MOVWF       _Out8+1 
	GOTO        L_main103
L_main102:
	CLRF        _Out8+0 
	CLRF        _Out8+1 
L_main103:
;COCKPIT_ENTRY.c,213 :: 		if (aip & 2) Out9  = 1; else Out9  = 0;
	BTFSS       main_aip_L0+0, 1 
	GOTO        L_main104
	MOVLW       1
	MOVWF       _Out9+0 
	MOVLW       0
	MOVWF       _Out9+1 
	GOTO        L_main105
L_main104:
	CLRF        _Out9+0 
	CLRF        _Out9+1 
L_main105:
;COCKPIT_ENTRY.c,214 :: 		if (aip & 4) Out10 = 1; else Out10 = 0;
	BTFSS       main_aip_L0+0, 2 
	GOTO        L_main106
	MOVLW       1
	MOVWF       _Out10+0 
	MOVLW       0
	MOVWF       _Out10+1 
	GOTO        L_main107
L_main106:
	CLRF        _Out10+0 
	CLRF        _Out10+1 
L_main107:
;COCKPIT_ENTRY.c,215 :: 		if (aip & 8) Out11 = 1; else Out11 = 0;
	BTFSS       main_aip_L0+0, 3 
	GOTO        L_main108
	MOVLW       1
	MOVWF       _Out11+0 
	MOVLW       0
	MOVWF       _Out11+1 
	GOTO        L_main109
L_main108:
	CLRF        _Out11+0 
	CLRF        _Out11+1 
L_main109:
;COCKPIT_ENTRY.c,216 :: 		}
	GOTO        L_main25
;COCKPIT_ENTRY.c,217 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

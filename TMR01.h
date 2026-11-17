// Timer1 tick: Fosc/4 = 4 MHz (16 MHz INTOSC), prescale 1:8 -> 2 us per count.
// Preload 0xFC00 -> 1024 counts -> one interrupt every 2.048 ms.

volatile unsigned char cnt = 0;      // free-running tick counter, never reset by main

void Inittimer() {
 T1CON          = 0b00110111;      // Fosc/4, prescale 1:8, 16-bit read/write, timer on
 IPR1.TMR1IP    = 0;               // TMR1 low priority
 IPR1.RC1IP     = 1;
 IPR1.TX1IP     = 1;
 TMR1IF_bit     = 0;
 TMR1H          = 0xFC;
 TMR1L          = 0x00;
 TMR1IE_bit     = 1;
 RCON.IPEN      = 1;
 INTCON.GIEH    = 1;
 INTCON.GIEL    = 1;
 INTCON.TMR0IE  = 0;
 INTCON.INT0IE  = 0;
 INTCON.RBIE    = 0;
 INTCON.TMR0IF  = 0;
 INTCON.INT0IF  = 0;
 INTCON.RBIF    = 0;
}

void dialtone_interrupt() iv 0x0018 ics ICS_AUTO {
 if (TMR1IF_bit){
  TMR1IF_bit = 0;
  TMR1H = 0xFC;
  TMR1L = 0x00;
  cnt++;
 }
}

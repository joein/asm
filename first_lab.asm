; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    "Press Enter to Exit",0AH,0DH,0

         .DATA
            ;A SDWORD -30; E2 FF FF FF
            ;B SDWORD  21; 15 00 00 00
            A DWORD -30;
            B DWORD 21;
            val1 BYTE 255; FF 
            chart WORD 256; 00 01
            lue3 SWORD -128; 80 FF
            alu BYTE ?; 00
            v5 BYTE 10h; 10
               BYTE 100101B; 25
            beta BYTE 23,23h,0ch; 17 23 0C
            sdk BYTE "Hello",0; 48 65 6C 6C 6F 00
            min SWORD -32767; 01 80
            ar DWORD 12345678h; 78 56 34 12
            valar BYTE 5 DUP (1, 2, 8); 01 02 08 01 02 08 01 02 08 01 02 08 01 02 08
            first SWORD 25; 19 00
            second SDWORD -35; DD FF FF FF
            imya BYTE "≈√Œ–EGOR",0; C5 C3 DE D0 45 47 4F 52 00
            third_1 WORD 37;
            third_2 SWORD 37;
            third_3 WORD 25h;
            third_4 SWORD 25h;
            fourth_1 WORD 9472;
            fourth_2 SWORD 9472;
            fourth_3 WORD 2500h;
            fourth_4 SWORD 2500h;
            F1 WORD 65535; FF FF
            F2 DWORD 65535; FF FF 00 00

         .DATA?
            X SDWORD   ?
inbuf    DB    100 DUP (?)

         .CODE
Start:
; 
;    Add you statements
;
         MOV    EAX,A
         ADD    EAX,5
         SUB    EAX,B
         MOV    X,EAX
         ADD    F1,1
         ADD    F2,2
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start


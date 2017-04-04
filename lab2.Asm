; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    13,10,"Press Enter to Exit",0AH,0DH,0
MsgError DB    "Division by zero error",0AH,0DH,0
         .DATA
         N  SWORD ?
         fN SWORD 0
         Zapros1 DB 13,10,'Input A',13,10,0
         Zapros2 DB 13,10,'Input B',13,10,0
         Zapros3 DB 13,10,'Input X',13,10,0
         Zapros4 DB 13,10,'Input Y',13,10,0
         Result DB 'Result='
         ResStr DB 16 DUP (' '),0 
         .DATA?
         X  SWORD ?
         fX SWORD ?
         B  SWORD ?
         fB SWORD ?
         A  SWORD ?
         fA SWORD ?
         Y  SWORD ?
         fY SWORD ?
Buffer   DB 10 DUP(?)
inbuf    DB    100 DUP (?)

         .CODE
Start:
; 
;    Add you statements
;
         Invoke StdOut,ADDR Zapros1 
         Invoke StdIn,ADDR Buffer,LengthOf Buffer 
         Invoke StripLF,ADDR Buffer 
         Invoke atol,ADDR Buffer ;результат в EAX 
         mov DWORD PTR A,EAX 
         Invoke StdOut,ADDR Zapros2 
         Invoke StdIn,ADDR Buffer,LengthOf Buffer 
         Invoke StripLF,ADDR Buffer 
         Invoke atol,ADDR Buffer ;результат в EAX 
         mov DWORD PTR B,EAX 
         Invoke StdOut,ADDR Zapros3 
         Invoke StdIn,ADDR Buffer,LengthOf Buffer 
         Invoke StripLF,ADDR Buffer 
         Invoke atol,ADDR Buffer ;результат в EAX 
         mov DWORD PTR X,EAX 
         Invoke StdOut,ADDR Zapros4 
         Invoke StdIn,ADDR Buffer,LengthOf Buffer 
         Invoke StripLF,ADDR Buffer 
         Invoke atol,ADDR Buffer ;результат в EAX 
         mov DWORD PTR Y,EAX 
         mov BX,A 
         mov AX,X 
         imul AX 
         imul BX 
         mov BX,AX 
         mov DX,B 
         mov CX,A 
         mov AX,Y 
         imul DX
         cmp CX,0
         je exception ; проверка деления на ноль
         idiv CX 
         sub BX,AX 
         mov CX,Y 
         add CX,A 
         mov DX,1 
         mov AX,X 
         imul DX
         cmp CX,0
         je exception ; проверка деления на ноль
         idiv CX 
         add BX,AX 
         mov N,BX
         Invoke dwtoa,N,ADDR ResStr 
         Invoke StdOut,ADDR Result
         jmp fin 
     exception: ; обработка ошибки деления на ноль
         Invoke StdOut,ADDR MsgError
     fin:
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start


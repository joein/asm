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
MsgError DB    13,10,"Division by zero",0AH,0DH,0
.DATA
         N  SWORD ?
         fN SWORD 0
         Zapros1 DB 13,10,'Input A',13,10,0
         Zapros2 DB 13,10,'Input X',13,10,0
         Zapros3 DB 13,10,'Input Y',13,10,0
         Result DB 'Result='
         ResStr DB 16 DUP (' '),0 
         .DATA?
         X  SWORD ?
         fX SWORD ?
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
         Invoke StdOut,ADDR Zapros3 
         Invoke StdIn,ADDR Buffer,LengthOf Buffer 
         Invoke StripLF,ADDR Buffer 
         Invoke atol,ADDR Buffer ;результат в EAX 
         mov DWORD PTR Y,EAX 
         Invoke StdOut,ADDR Zapros2 
         Invoke StdIn,ADDR Buffer,LengthOf Buffer 
         Invoke StripLF,ADDR Buffer 
         Invoke atol,ADDR Buffer ;результат в EAX 
         mov DWORD PTR X,EAX 
         mov AX,A
         cmp AX,Y
         jl less
         mov AX,A
         imul X
         imul X
         jmp continue
    less:
         mov DX,1
         mov AX,A
         mov BX,Y
         ADD BX,A
         cmp BX,0
         je exception
         imul DX
         idiv BX
         jmp continue
    exception: 
         Invoke StdOut,ADDR MsgError
         jmp fin
    continue:
         MOV N,AX
         Invoke dwtoa,N,ADDR ResStr 
         Invoke StdOut,ADDR Result 
    fin:
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start


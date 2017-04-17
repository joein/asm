; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB   0AH,0DH,"Press Enter to Exit",0AH,0DH,0
MsgErrorLength  DB 0AH,0DH,"Wrong length of word, it should be 7",0AH,0DH,0
MsgErrorQuantity DB 0AH,0DH,"Wrong quantity of words, it should be 5",0AH,0DH,0
MsgToInput DB 0AH,0DH,"Input 5 word in english, length of each word - 7 symbols",0AH,0DH,0

;no db 'not'
;yes db 'yes'
.DATA
         strv db 50 dup(?)
         rez dd ?
         rezstr db 25 dup(?),0
         my_arr db 42 dup(' ')
        
         .DATA?
         
inbuf    DB    100 DUP (?)
buf1     db    7 dup (?)
buf2     db    7 dup (?)

         .CODE
Start:
         mov ecx,0
         Invoke StdOut,ADDR MsgToInput
         Invoke StdIn,ADDR strv,LengthOf strv 
         Invoke StripLF,ADDR strv
         lea edi,strv
         mov ecx,50 
         mov al,0
  repne scasb
         mov ax,50
         sub ax,cx
         mov cx,ax
         dec cx
         lea edi,strv
         mov al,' '
         mov ebx,0
         cld
        
  cic1:  cmp cx,0
         je con
         mov dx,0
  cic2:  scasb
         je consl
         inc dx
         dec cx
         jmp cic2
  consl: cmp dx,7
         jne errLength
         inc bx
         dec cx
         jmp cic1
  con:  
         cmp ebx,5
         jne errQuant
         mov rez,ebx
         mov ecx, 40
         lea esi, strv
         lea edi, my_arr
         rep movsb
         
        mov ebx, 0
Cycle1: 
        mov edx, 0
Cycle2:
        
        
        mov ecx, 7
        lea esi, my_arr[edx*8]
        lea edi, buf1
        rep movsb
        
        mov ecx, 7
        lea esi, my_arr[edx*8+8]
        lea edi, buf2
        rep movsb
        
        mov ecx, 7
        lea esi, buf1
        lea edi, buf2
        repe cmpsb
        jg BChange
Cont:
        inc edx
        mov eax, 5
        sub eax, ebx
        cmp edx, eax
        jl Cycle2
        
        inc ebx
        cmp ebx, 5
        jl Cycle1
        
        jmp print

BChange:
        push ebx
        mov ebx, 0
Change:
        mov al, my_arr[edx*8+ebx]
        push eax
        mov al, my_arr[edx*8+8+ebx]
        mov my_arr[edx*8+ebx], al
        pop eax
        mov my_arr[edx*8+8+ebx], al
        inc ebx
        cmp ebx, 7
        jne Change
        
        pop ebx
        jmp Cont
         

         
  errLength:
         Invoke StdOut, ADDR MsgErrorLength
         jmp print
  errQuant:
         Invoke StdOut, ADDR MsgErrorQuantity
  print:
         lea esi, my_arr
         add esi, 8
         Invoke StdOut, esi
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start


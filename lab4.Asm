; Template for console application
        .586
        .MODEL  flat, stdcall
        OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

        .CONST
MsgExit DB      10,13,"Press Enter to Exit",10,13,0

        .DATA
MsgInp  db      "Input array with spaces: ",10,13,0
MsgOrg  db      "Original array: ",0
MsgRes  db      10,13,"Result array:   ",0
space   db      " "

        .DATA?
inbuf   DB      100 DUP (?)

arr_str DB      200 dup (?)
len_str dd      ?
arr     dd      28 dup (?)
len     dd      ?
res     db      10 dup (?)

        .CODE
Start:
        Invoke StdOut,ADDR MsgInp
        Invoke StdIn,ADDR arr_str,LengthOf arr_str
        sub eax, 2
        mov len_str, eax
        Invoke StripLF,ADDR arr_str
        
        cld
        lea edi, arr_str
        mov ecx, len_str
        mov ebx, 0
CycleS:
        push ecx
        Invoke atol, edi
        mov arr[ebx*4], eax
        inc ebx
        
        pop ecx
        mov al, space
        repne scasb
        je CycleS
        
        mov len, ebx
        
        Invoke StdOut,ADDR MsgOrg
        mov esi, 0
OutpOrg:   
        Invoke dwtoa, arr[esi*4], ADDR res
        Invoke StdOut, ADDR res
        Invoke StdOut, ADDR space
        inc esi
        cmp esi, len
        jl OutpOrg

        mov esi, 0
        mov edi, 0
Cycle: 
        cmp arr[esi*4],0
        jl Nego
        jg Pos
        jmp Next
Nego:
        mov ebx, edi
        inc edi
        cmp esi, ebx
        je Next
        jmp Cont
Pos:
        cmp esi, edi
        je Next
        mov ebx, edi
        inc ebx
Cont:
        mov ecx, esi
;Start Shift
        mov eax, arr[ecx*4]
        push eax
CycleSh:  
        dec ecx
        mov eax, arr[ecx*4]
        mov arr[ecx*4 + 4], eax
        cmp ecx, ebx
        jg CycleSh
        
        pop eax
        mov arr[ecx*4], eax
;End Shift
Next:
        inc esi
        cmp esi, len
        jl Cycle

        Invoke StdOut,ADDR MsgRes
        mov esi, 0
OutpRes:   
        Invoke dwtoa, arr[esi*4], ADDR res
        Invoke StdOut, ADDR res
        Invoke StdOut, ADDR space
        inc esi
        cmp esi, len
        jl OutpRes
        
        XOR    EAX,EAX
        Invoke StdOut,ADDR MsgExit
        Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
        Invoke ExitProcess,0
        End    Start

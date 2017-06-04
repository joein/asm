; Template for console application
        .586
        .MODEL  flat, stdcall
        OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

        .CONST
MsgInp  DB      "Input array:", 10,13,0
MsgExit DB      "Press Enter to Exit",0AH,0DH,0
MsgOrg  db      "Original matrix:",10,13,0
MsgRes  db      "Result: ",0
spc     db      " ",0
ent     db      10,13,0

        .DATA

n       dd      5
space   db      " "
        .DATA?
inbuf   DB      100 DUP (?)
arr_str DB 100 DUP(?)
arr_length DB ? 
arr DD 25 DUP(?)
len dd ?
len_str dd ?

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
    mov ebx, 0
Outp1:
        mov ecx, 0
Outp2:
        push ebx
        push ecx
        Invoke dwtoa, arr[ebx][ecx*4], ADDR res
        Invoke StdOut, ADDR res
        Invoke StdOut, ADDR spc
        pop ecx
        pop ebx
        inc ecx
        cmp ecx, n
        jl Outp2
        
        Invoke StdOut, ADDR ent
        add ebx, 20
        cmp ebx, 100
        jl Outp1

        mov ecx, arr[0][4]
        mov ebx, 0 
Cycle1:
        mov eax, ebx 
        xor edx, edx 
        mov ebp, 20 
        div ebp
        add eax, 1 
Cycle2:
        cmp ecx, arr[ebx][eax*4] 
        jnl Cont 
        
        mov ecx, arr[ebx][eax*4] 
Cont:   
        inc eax 
        cmp eax, n
        jl Cycle2
        
        add ebx, 20 
        cmp ebx, 80 
        jl Cycle1 
        
        Invoke dwtoa, ecx, ADDR res
        Invoke StdOut, ADDR MsgRes
        Invoke StdOut, ADDR res
        Invoke StdOut, ADDR ent

        XOR    EAX,EAX
        Invoke StdOut,ADDR MsgExit
        Invoke StdIn,ADDR inbuf,LengthOf inbuf		

        Invoke ExitProcess,0
        End    Start
; dynamic.asm  — Winx64 MASM iterative Fibonacci
OPTION CASEMAP:NONE     ; preserve case

; fib: int fib(int n)
;   RCX = n (signed 32-bit), returns in EAX
PUBLIC  fib
.code
fib PROC
    ; ——— Prologue: make room for the 32-byte shadow + 8-byte align
    sub     rsp, 40

    ; copy n → eax for possible “return n”
    mov     eax, ecx

    ; if n < 0: return 0
    cmp     ecx, 0
    jl      Lreturn_zero

    ; if n == 0 or n == 1: return n
    cmp     ecx, 1
    jle     Lreturn_n

    ; ——— iterative case: 2 ≤ n ≤ 30
    xor     ebx, ebx        ; ebx = a = 0
    mov     edx, 1          ; edx = b = 1
    mov     r8d, 2          ; r8d = i = 2

LoopStart:
    cmp     r8d, ecx
    ja      LoopDone        ; if i > n, done

    
    lea     r9d, [ebx + edx]    ; c = a + b
    mov     ebx, edx            ; a = b
    mov     edx, r9d            ; b = c
    inc     r8d                 ; i++
    jmp     LoopStart

LoopDone:
    ; result = b
    mov     eax, edx
    jmp     Epilogue

Lreturn_n:
    ; eax already = ecx (n)
    jmp     Epilogue

Lreturn_zero:
    xor     eax, eax        ; result = 0

Epilogue:
    ; restore stack & return
    add     rsp, 40
    ret
fib ENDP
END

; hello.asm   — ml64-friendly
OPTION CASEMAP:NONE         ; optional: preserve case

;--- externs (no @4 suffix in x64) ------------------
EXTERN  ExitProcess:PROC
EXTERN  MessageBoxA:PROC

;--- make our symbol visible to the linker -----------
PUBLIC  hello_message

;--- data section ------------------------------------
.data
    caption db "Winx64AsmPlayground",0
    text    db "Hello from MASM x64!",0

;--- code section ------------------------------------
.code
hello_message PROC
    ; 32-byte “shadow space” + 8-byte alignment
    sub     rsp, 40

    mov     rcx, 0              ; hWnd = NULL
    lea     rdx, text           ; LPCSTR lpText
    lea     r8,  caption        ; LPCSTR lpCaption
    mov     r9d, 0              ; MB_OK == 0

    call    MessageBoxA

    ; epilogue
    add     rsp, 40             ; restore stack
    ret                         ; return to caller (main)
hello_message ENDP

END

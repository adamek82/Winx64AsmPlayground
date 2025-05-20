; arrays.asm — Win64 MASM: sum a sub-matrix 0..(nrows-1) × 0..(ncols-1)
;
; int matrx_sum(const int (*matrix)[NCOLS],
;               int arrWidth,  int arrHeight,
;               int nrows,     int ncols)
;
; RCX = matrix ptr
; RDX = arrWidth      (row count in memory)
; R8D = arrHeight     (col count in memory)
; R9D = nrows         (rows to sum)
; 5th param = ncols   (on stack at [rsp+8] before we allocate shadow-space)
; Returns sum in EAX
;
OPTION CASEMAP:NONE
PUBLIC matrx_sum

.code
matrx_sum PROC
        sub     rsp, 40                 ; 32-byte shadow + 8-byte align

        ; ---- load parameters -------------------------------------------
        mov     r10, rcx                ; r10 = base pointer
        mov     r11d, edx               ; r11d = arrWidth
        mov     r12d, r8d               ; r12d = arrHeight
        mov     r13d, r9d               ; r13d = nrows to process

        ; 5th argument (ncols) is on stack: was 48, now 48+40 = 88
        mov     r14d, DWORD PTR [rsp+80]   ; r14d = ncols to process

        xor     eax, eax                ; EAX = running sum (result)

        ; strideBytes = arrHeight * 4 (size of a row in bytes)
        lea     r15d, [r12d*4]

        ; ---- outer loop over rows --------------------------------------
RowLoop:
        test    r13d, r13d              ; finished all rows?
        jz      Done

        mov     r8d, r14d               ; r8d = remaining cols for this row
        mov     r9,  r10                ; r9  = pointer to first element in row

ColLoop:
        test    r8d, r8d
        jz      NextRow

        add     eax, DWORD PTR [r9]     ; sum += *ptr
        add     r9, 4                   ; ++ptr (sizeof(int))
        dec     r8d
        jmp     ColLoop

NextRow:
        add     r10, r15                ; advance to next row
        dec     r13d
        jmp     RowLoop

Done:
        add     rsp, 40
        ret
matrx_sum ENDP
END

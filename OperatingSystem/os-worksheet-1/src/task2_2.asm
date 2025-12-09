%include "asm_io.inc"

segment .bss
arr resd 100

segment .text
global asm_main

asm_main:
    enter 0,0
    pusha

    ; Fill array: arr[i] = i+1  for i=0..99
    xor ecx, ecx
.fill:
    cmp ecx, 100
    jge .sum_start
    mov eax, ecx
    inc eax
    mov [arr + ecx*4], eax
    inc ecx
    jmp .fill

.sum_start:
    ; sum array
    xor ecx, ecx
    xor eax, eax          ; eax = sum
.sum:
    cmp ecx, 100
    jge .print
    add eax, [arr + ecx*4]
    inc ecx
    jmp .sum

.print:
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits

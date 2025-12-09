%include "asm_io.inc"

segment .data
a dd 10
b dd 32

segment .text
global asm_main

asm_main:
    enter 0,0
    pusha

    mov eax, [a]
    add eax, [b]
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret

%include "asm_io.inc"

segment .data
prompt_lo db "Enter low (1..100): ", 0
prompt_hi db "Enter high (1..100): ", 0
err_msg   db "Error: must satisfy 1 <= low <= high <= 100", 0

segment .bss
arr resd 100

segment .text
global asm_main

asm_main:
    enter 0,0
    pusha

    ; Fill array: arr[i] = i+1
    xor ecx, ecx
.fill:
    cmp ecx, 100
    jge .inputs
    mov eax, ecx
    inc eax
    mov [arr + ecx*4], eax
    inc ecx
    jmp .fill

.inputs:
    ; Read low
    mov eax, prompt_lo
    call print_string
    call read_int
    mov ebx, eax          ; ebx = low

    ; Read high
    mov eax, prompt_hi
    call print_string
    call read_int
    mov edx, eax          ; edx = high

    ; Validate: 1 <= low <= high <= 100
    cmp ebx, 1
    jl .error
    cmp edx, 100
    jg .error
    cmp ebx, edx
    jg .error

    ; Convert to 0-based indices:
    dec ebx               ; low_index  = low - 1
    dec edx               ; high_index = high - 1

    ; Sum arr[low_index..high_index]
    xor eax, eax          ; sum
    mov ecx, ebx          ; i = low_index
.sum:
    cmp ecx, edx
    jg .print
    add eax, [arr + ecx*4]
    inc ecx
    jmp .sum

.print:
    call print_int
    call print_nl
    jmp .done

.error:
    mov eax, err_msg
    call print_string
    call print_nl

.done:
    popa
    mov eax, 0
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits

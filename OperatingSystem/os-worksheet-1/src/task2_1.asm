%include "asm_io.inc"

segment .data
prompt_name   db "Enter your name: ", 0
prompt_num    db "Enter a number (51..99): ", 0
err_msg       db "Error: number must be > 50 and < 100", 0
welcome_msg   db "Welcome ", 0

segment .bss
name_buf  resb 64

segment .text
global asm_main

asm_main:
    enter 0,0
    pusha

    ; ---- read name using read_char into name_buf ----
    mov eax, prompt_name
    call print_string

    mov edi, name_buf      ; write pointer
    xor ecx, ecx           ; length = 0

.read_name:
    call read_char         ; AL = char
    cmp al, 10             ; Enter (LF) on many systems
    je  .end_name
    cmp al, 13             ; Enter (CR) just in case
    je  .end_name

    mov [edi], al
    inc edi
    inc ecx
    cmp ecx, 63            ; keep space for null terminator
    jl  .read_name

.end_name:
    mov byte [edi], 0      ; null-terminate string

    ; ---- read number ----
    mov eax, prompt_num
    call print_string
    call read_int
    mov ebx, eax           ; ebx = number

    ; Validate: number > 50 AND number < 100
    cmp ebx, 50
    jle .error
    cmp ebx, 100
    jge .error

    ; Loop ebx times: "Welcome <name>"
    xor ecx, ecx
.loop:
    cmp ecx, ebx
    jge .done

    mov eax, welcome_msg
    call print_string
    mov eax, name_buf
    call print_string
    call print_nl

    inc ecx
    jmp .loop

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

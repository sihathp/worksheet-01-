%include "asm_io.inc"

segment .data
prompt_name db "Enter your name: ", 0
prompt_count db "How many welcomes (51..99)? ", 0
err_msg db "Error: number must be > 50 and < 100", 0
welcome db "Welcome ", 0

segment .bss
name_buf resb 64

segment .text
global asm_main

asm_main:
    enter 0,0
    pusha

    ; ask name
    mov eax, prompt_name
    call print_string
    ; NOTE: depending on your asm_io, replace next line with the correct function
    ; call read_string
    ; (or implement a simple char-read loop into name_buf)

    ; ask count
    mov eax, prompt_count
    call print_string
    call read_int          ; eax = count
    mov ebx, eax           ; ebx = count

    ; validate: count > 50 and count < 100
    cmp ebx, 50
    jle .error
    cmp ebx, 100
    jge .error

    ; loop: for i=0; i<count; i++
    xor ecx, ecx           ; i=0
.loop:
    cmp ecx, ebx
    jge .done

    mov eax, welcome
    call print_string
    ; print name_buf if supported; otherwise print chars from buffer
    ; mov eax, name_buf
    ; call print_string
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

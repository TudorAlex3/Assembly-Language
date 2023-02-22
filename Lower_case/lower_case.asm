section .rodata
    text_string db "ana are mere", 0
    format_print db "%s", 10, 0
    format_res db "Res - %d", 10, 0

section .text
    extern printf
    extern scanf

global main

    ; int lower_case(char* string)
    ; return 1 if all characters are lowercase
lower_case:
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8]
    mov ecx, 0
    mov edx, 0
    mov eax, 1

test_char:
    mov dl, byte[ebx+ecx]

    ; string[ecx] - string terminator
    cmp edx, 0
    je done

    ; string[ecx] < A
    cmp edx, 65
    jl continue_test

    ; string[ecx] < Z
    cmp edx, 90
    jle not_lower_case

continue_test:
    add ecx, 1
    jmp test_char

not_lower_case:
    mov eax, 0

done:
    leave
    ret

main:
    push ebp
    mov ebp, esp
    
    ; read and print input
    ;----------------------;
    push text_string
    push format_print
    call printf
    add esp, 8
    ;----------------------;


    ; call strchr(char* string, char c)
    ;----------------------;
    push text_string
    call lower_case
    add esp, 4

    push eax
    push format_res
    call printf
    add esp, 8
    ;----------------------;

    leave
    ret
section .data
    read_format db "%zu", 0
    print_format db "Number = %d", 10, 0
    string_print db "Square root = %d", 10, 0
    number dd 0

section .text
    extern printf
    extern scanf
    extern sqrt

global main

square_root:
    push ebp
    mov ebp, esp
    push ebx

    mov ebx, [ebp+8]

    mov ecx, 0
find_root:
    mov eax, ecx
    mul eax

    cmp eax, ebx
    je root_found

    cmp eax, ebx
    jg continue_searching

    inc ecx
    jmp find_root

continue_searching:
    dec ecx
    mov eax, ecx

root_found:
    mov eax, ecx

    pop ebx
    leave
    ret

main:
    push ebp
    mov ebp, esp
    push ebx

    push number
    push read_format
    call scanf
    add esp, 8

    push dword[number]
    push print_format
    call printf
    add esp, 8

    push dword[number]
    call square_root
    add esp, 4

    push eax
    push string_print
    call printf
    add esp, 8

    pop ebx
    leave
    ret
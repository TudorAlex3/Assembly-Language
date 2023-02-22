section .data
    scan_format db "%zu", 0
    print_number db "Number = %d", 10, 0
    print_bit db "%d", 0
    print_new_line db 10, 0

section .text
    extern printf
    extern scanf

global main

    ; void show_bit(int a)
show_bit:
    push ebp
    mov ebp, esp

    mov ecx, 32

    ; ebx is mask
    mov ebx, 1
    shl ebx, 31

print_bit_function:
    mov edx, [ebp+8]
    and edx, ebx

    cmp edx, 0
    je bit_0
    mov edx, 1
    jmp bit_1

bit_0:
    mov edx, 0

bit_1:
    ;save ebx, ecx
    push ebx
    push ecx

    ; print bit
    push edx
    push print_bit
    call printf
    add esp, 8

    ; restore ebx and ecx
    pop ecx
    pop ebx
    shr ebx, 1
    loop print_bit_function

    push print_new_line
    call printf
    add esp, 4

    leave
    ret

main:
    push ebp
    mov ebp, esp
    sub esp, 4
    
    ; read and print number
    ;----------------------;
    mov eax, esp
    push eax
    push scan_format
    call scanf
    add esp, 8

    push dword[esp]
    push print_number
    call printf
    add esp, 8
    ;----------------------;

    ; print bits
    ;----------------------;
    push dword[esp]
    call show_bit
    add esp, 4
    ;----------------------;
    add esp, 4
    leave
    ret
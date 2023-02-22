section .data
    scan_format db "%zu", 0
    print_base db "Base = %d", 10, 0
    print_pow db "Pow = %d", 10, 0
    print_res db "pow(%d, %d) = %d", 10, 0

section .text
    extern printf
    extern scanf

global main

    ;int pow_a_b(int a, int b)
    ; a - base, b - exponent (b>=0)
pow_a_b:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+8] ; a
    mov ebx, [ebp+12] ; b

    ; a = 0 -> a^b = 0
    cmp eax, 0
    je base_0

    ; a = 1 -> a^b = 1
    cmp eax, 1
    je pow_0

    ; b = 0 -> a^b = 1
    cmp ebx, 0
    je pow_0

    dec ebx
    push ebx
    push eax
    call pow_a_b
    add esp, 8

    mov ebx, [ebp+8] ; a
    mul ebx
    jmp done_pow

base_0:
    mov eax, 0
    jmp done_pow

pow_0:
    mov eax, 1

done_pow:
    leave
    ret

main:
    push ebp
    mov ebp, esp
    sub esp, 8
    
    ; read and print input
    ;----------------------;
    lea eax, [ebp-4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    lea eax, [ebp-8]
    push eax
    push scan_format
    call scanf
    add esp, 8

    push dword[ebp-4]
    push print_base
    call printf
    add esp, 8

    push dword[ebp-8]
    push print_pow
    call printf
    add esp, 8
    ;----------------------;

    ; call pow(a,b)
    ;----------------------;
    push dword[ebp-8]
    push dword[ebp-4]
    call pow_a_b
    add esp, 8

    push eax
    push dword[ebp-8]
    push dword[ebp-4]
    push print_res
    call printf
    add esp, 16
     ;----------------------;

    add esp, 8
    leave
    ret
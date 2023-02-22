section .data
    pow db "pow = %d", 10, 0
    res db "pow(2, %d) = %d", 10, 0
    scan_format db "%zu", 0

section .text
    extern printf
    extern scanf

global main

    ;int pow_2_n(int n)
pow_2_n:
    push ebp
    mov ebp, esp

    mov ecx, [ebp+8]
    mov eax, 1

    ;2^0
    cmp eax, 0
    je pow_found

calc_pow:
    shl eax, 1
    loop calc_pow

pow_found:
    leave
    ret

main:
    push ebp
    mov ebp, esp
    sub esp, 4
    
    ; read and print pow
    ;----------------------;
    push esp
    push scan_format
    call scanf
    add esp, 8

    push dword[esp]
    push pow
    call printf
    add esp, 8
    ;----------------------;

    ; pow(2,n)
    ;----------------------;
    push dword[esp]
    call pow_2_n
    add esp, 4

    push eax
    push dword[ebp-4]
    push res
    call printf
    add esp, 12
    ;----------------------;

    add esp, 4
    leave
    ret
section .data
    scan_format db "%zu", 0
    print_number1 db "Number1 = %d", 10, 0
    print_number2 db "Number2 = %d", 10, 0
    print_gcd db "GCD(%d, %d) = %d", 10, 0

section .text
    extern printf
    extern scanf

global main

    ;int gcd(int a, int b)
gcd:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
    mov ebx, [ebp+12]

    cmp ebx, 0
    je done

    xor edx, edx
    div ebx

    mov ebx, [ebp+12]
    push edx
    push ebx
    call gcd
    add esp, 8

done:

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
    push print_number1
    call printf
    add esp, 8

    push dword[ebp-8]
    push print_number2
    call printf
    add esp, 8
    ;----------------------;


    ; call gcd(int a, int b)
    ;----------------------;
    push dword[ebp-8]
    push dword[ebp-4]
    call gcd
    add esp, 8

    push eax
    push dword[ebp-8]
    push dword[ebp-4]
    push print_gcd
    call printf
    add esp, 16
    ;----------------------;

    add esp, 8
    leave
    ret
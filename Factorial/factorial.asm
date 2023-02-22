section .data
    scan_format db "%zu", 0
    print_number db "Number = %d", 10, 0
    print_fact db "%d! = %d", 10, 0

section .text
    extern printf
    extern scanf

global main

    ;int factorial(int a)
factorial:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+8] ; a

    cmp eax, 0 ; a = 0 -> !a = 1
    je number_0

    dec eax
    push eax
    call factorial
    add esp, 4

    mov ebx, [ebp+8] ;a
    mul ebx
    jmp result

number_0:
    mov eax, 1

result:
    leave
    ret

main:
    push ebp
    mov ebp, esp
    sub esp, 4
    
    ; read and print input
    ;----------------------;
    lea eax, [ebp-4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    push dword[ebp-4]
    push print_number
    call printf
    add esp, 8
    ;----------------------;

    ; call factorial(int a)
    ;----------------------;
    push dword[ebp-4]
    call factorial
    add esp, 4

    push eax
    push dword[ebp-4]
    push print_fact
    call printf
    add esp, 12
    ;----------------------;

    add esp, 4
    leave
    ret
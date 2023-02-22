section .data
    scan_format db "%zu", 0
    print_number db "Number = %d", 10, 0
    print_bits db "Bits = %d", 10, 0
    print_even db "Even number", 10 ,0
    print_odd db "Odd number", 10 ,0

section .text
    extern printf
    extern scanf

global main

    ;int count_1_bits(int a)
coubt_1_bits:
    push ebp
    mov ebp, esp

    mov eax, 0
    mov ecx, 32
    mov edx, 1 ; mask

count:
    mov ebx, [ebp+8]
    and ebx, edx

    cmp ebx, 0
    je bit_0

    add eax, 1

bit_0:
    shl edx, 1
    loop count

    leave
    ret

    ;int even_odd(int number_of_bits)
even_odd:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
    mov ebx, 2
    mov edx, 0
    div ebx

    cmp edx, 0
    je even
    push print_odd
    call printf
    add esp, 4
    jmp done

even:
    push print_even
    call printf
    add esp, 4

done:
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


    ; call count_1_bits(int a)
    ;----------------------;
    push dword[ebp-4]
    call coubt_1_bits
    add esp, 4

    push eax
    push eax
    push print_bits
    call printf
    add esp, 8
    pop eax
    ;----------------------;

    ; call even_odd(int number_of_bits)
    ;----------------------;
    push eax
    call even_odd
    add esp, 4
    ;----------------------;


    add esp, 4
    leave
    ret
section .data
    num dd 0
    print_num db "Numar = %d", 10, 0
    print_digits db "Digits = %d", 10, 0
    print_digits_sum db "Sum = %d", 10, 0
    scan_format db "%zu", 0

section .text
    extern printf
    extern scanf

global main

    ;int count_digits(int a)
count_digits:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8] ; number
    mov ecx, 0
div_by_10:
    inc ecx

    mov esi, 10
    mov edx, 0
    div esi

    cmp eax, 0
    jne div_by_10

    mov eax, ecx
    leave
    ret

digits_sum:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8] ; number
    mov ecx, 0
add_digit:
    mov esi, 10
    mov edx, 0
    div esi
    add ecx, edx
    xor edx, edx

    cmp eax, 0
    jne add_digit

    mov eax, ecx
    leave
    ret

main:
    push ebp
    mov ebp, esp
    
    ; Read and print num
    ;------------------;
    push num
    push scan_format
    call scanf
    add esp, 8

    push dword[num]
    push print_num
    call printf
    add esp, 8
    ;------------------;


    ; Find number of digits
    ;----------------------;
    push dword[num]
    call count_digits
    add esp, 4

    push eax
    push print_digits 
    call printf
    add esp, 8
    ;----------------------;

    ; Sum of digits
    ;---------------;
    push dword[num]
    call digits_sum
    add esp, 4

    push eax
    push print_digits_sum 
    call printf
    add esp, 8
    ;----------------------;
    
    leave
    ret
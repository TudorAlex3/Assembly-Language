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

    ;a < 10 ? 1 : 1 + rec_num_digits(a/10)
    mov ebx, [ebp + 8]
    cmp ebx, 10
    jl sum_base_case

    ;a = eax && eax /= 10
    mov eax, ebx
    mov edx, 0
    mov ebx, 10
    div ebx

    ;rec_num_digits(a/10)
    push eax
    call count_digits
    add esp, 4

    ;1 + rec_num_digits(a/10)
    inc eax
    jmp num_done

num_base_case:
    mov eax, 1

num_done:
    leave
    ret

digits_sum:
    push ebp
    mov ebp, esp

    ;a < 10 ? a : a%10 + rec_sum_digits(a/10)
    mov ebx, [ebp + 8]
    cmp ebx, 10
    jl sum_base_case

    ;a = eax && eax /= 10
    mov eax, ebx
    mov edx, 0
    mov ebx, 10
    div ebx

    ;rec_sum_digits(a/10)
    push edx
    push eax
    call digits_sum
    add esp, 4
    pop edx

    ;a%10 + rec_sum_digits(a/10)
    add eax, edx
    jmp sum_done

sum_base_case:
    mov eax, ebx

sum_done:

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
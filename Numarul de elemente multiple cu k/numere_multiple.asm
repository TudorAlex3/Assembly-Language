section .rodata
    vect1 dd 1, 2, 3, 4, 5, 6
    len1 dd 6
    print_k db "K = %d", 10, 0
    scan_k db "%zu", 0
    print_number db "Number of elements = %d", 10, 0

section .data
    print_sum db "Sum = %d", 10, 0

section .text
    extern printf
    extern scanf

global main

    ; int number_of_elements(int k)
number_of_elements:
    push ebp
    mov ebp, esp

    mov ecx, [len1]
    sub ecx, 1
    mov eax, 0
    mov edx, 0
parcurgere:
    mov ebx, [ebp+8] ;k

    push eax
    mov eax, [vect1+ecx*4]
    xor edx, edx
    div ebx
    pop eax

    cmp edx, 0
    je add_multiple

    sub ecx, 1
    cmp ecx, 0
    jge parcurgere
    jmp done

add_multiple:
    add eax, 1
    sub ecx, 1
    cmp ecx, 0
    jge parcurgere

done:

    leave
    ret

main:
    push ebp
    mov ebp, esp
    sub esp, 4

    lea eax, [ebp-4]
    push eax
    push scan_k
    call scanf
    add esp, 8

    push dword[ebp-4]
    push print_k
    call printf
    add esp, 8

    push dword[ebp-4]
    call number_of_elements
    add esp, 4

    push eax
    push print_number
    call printf
    add esp, 8

    add esp, 4
    leave
    ret
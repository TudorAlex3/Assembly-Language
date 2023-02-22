section .rodata
    scan_format db "%zu", 0
    print_format db "Num = %d", 10, 0
    print_index_bit db "index of max bit from %d = %d", 10, 0

section .data
    num dd 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp

    ;read num
    push num
    push scan_format
    call scanf
    add esp, 8

    ;print num
    push dword [num]
    push print_format
    call printf
    add esp, 8

    ;index
    push dword [num]
    call index_max_bit
    add esp, 4

    push eax
    push dword [num]
    push print_index_bit
    call printf
    add esp, 12

    leave
    ret

    ;int index_max_bit(int num)
index_max_bit:
    push ebp
    mov ebp, esp

    mov ecx, 32         ;contor
    mov edx, 1          ;mask
    shl edx, 31

find_index:
    mov ebx, [ebp + 8]  ;num
    and ebx, edx

    cmp ebx, 0
    jne done_index

    shr edx, 1
    loop find_index

done_index:
    mov eax, ecx

    leave
    ret
section .data
    print_number db "Number = %x", 10, 0
    print_bit db "Order of bit = %x", 10, 0
    scan_format db "%zu", 0
    print_new_n db "New number = %x", 10, 0

section .text
    extern printf
    extern scanf

global main

    ; int change_bit_0(int n, int p)
change_bit_0:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8] ; n
    mov ecx, [ebp+12] ; p

    mov ebx, 1 ; mask

    cmp ecx, 0
    je jmp_make_masc_0

make_masc_0:
    shl ebx, 1
    loop make_masc_0
    
jmp_make_masc_0:
    not ebx
    and eax, ebx

    leave
    ret

; int change_bit_0(int n, int p)
change_bit_1:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8] ; n
    mov ecx, [ebp+12] ; p

    mov ebx, 1 ; mask

    cmp ecx, 0
    je jmp_make_masc_1

make_masc_1:
    shl ebx, 1
    loop make_masc_1
    
jmp_make_masc_1:
    or eax, ebx

    leave
    ret

main:
    push ebp
    mov ebp, esp
    
    sub esp, 8

    ; read number and p
    ;------------------;
    ; [ebp+4] -> n
    ; [ebp+8] -> p

    ; read n
    lea eax, [ebp-4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    ; read p
    lea eax, [ebp-8]
    push eax
    push scan_format
    call scanf
    add esp, 8

    push dword[ebp-4]
    push print_number
    call printf
    add esp, 8

    push dword[ebp-8]
    push print_bit
    call printf
    add esp, 8
    ;------------------;

    ; change p bit to 0
    ;------------------;
    push dword[ebp-8]
    push dword[ebp-4]
    call change_bit_0
    add esp, 8

    push eax
    push print_new_n
    call printf
    add esp, 8
    ;------------------;

    ; change p bit to 1
    ;------------------;
    push dword[ebp-8]
    push dword[ebp-4]
    call change_bit_1
    add esp, 8

    push eax
    push print_new_n
    call printf
    add esp, 8
    ;------------------;


    add esp, 8
    leave
    ret
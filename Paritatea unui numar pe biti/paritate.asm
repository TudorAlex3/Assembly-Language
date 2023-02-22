section .data
    print_number db "Num = %d", 10, 0
    scan_format db "%zu", 0
    print_res db "Number is even? -> %d", 10, 0

section .text
    extern printf
    extern scanf

global main

    ;int paritate(int n)
paritate:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+8]
    mov ebx, 1

    and eax, ebx
    cmp eax, 1
    je odd
    mov eax, 1
    jmp done

odd:
    mov eax, 0

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

    ; call pow(a,b)
    ;----------------------;
    push dword[ebp-4]
    call paritate
    add esp, 4

    push eax
    push print_res
    call printf
    add esp, 8
    ;----------------------;

    add esp, 8
    leave
    ret
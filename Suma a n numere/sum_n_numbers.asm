section .data
    myVect dd 1, 2, 3, 4, 5
    length dd 5
    string db "Sum = %d", 10, 0

section .text
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    mov ecx, [length]
    mov edx, myVect
    mov eax, 0

sum:
    add eax, dword [edx + ecx * 4 - 4]
    loop sum

    push eax
    push string
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret
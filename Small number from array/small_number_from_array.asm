section .data
    myVect dd 10, 29, 31, 5, 100
    length dd 5
    string db "Value = %d", 10, 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp

    mov ecx, [length]
    mov eax, [myVect]
small:
    mov edx, [myVect + 4 * ecx - 4]
    cmp eax, edx
    jl small_leave
    mov eax, edx
small_leave:
    loop small

    push eax
    push string
    call printf
    add esp, 8

    leave
    ret
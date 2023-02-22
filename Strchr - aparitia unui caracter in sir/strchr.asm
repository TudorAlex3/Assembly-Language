section .rodata
    test_string db "Ana are mere", 0
    print_chr db "Char = %c", 10, 0
    print_string db "%s", 10, 0
    scanf_format db "%c", 0

section .data
    chr_to_find db 0

section .text
    extern printf
    extern scanf

global main

    ; char* strchr(char* string, char c)
strchr:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8] ; string
    mov ebx, [ebp+12] ; c
    mov ecx, 0 ; contor
    mov edx, 0

search_char:
    mov dl, byte[eax+ecx] ; string[ecx]
    
    cmp edx, 0 ; end of string
    je char_not_found

    ; cmp string[ecx], c
    cmp edx, ebx
    je char_found

    inc ecx
    jmp search_char

char_not_found:
    mov eax, 0
    jmp done

char_found:
    add eax, ecx

done:
    leave
    ret

main:
    push ebp
    mov ebp, esp
    
    ; read and print input
    ;----------------------;
    push test_string
    push print_string
    call printf
    add esp, 8

    push chr_to_find
    push scanf_format
    call scanf
    add esp, 8

    push dword[chr_to_find]
    push print_chr
    call printf
    add esp, 8
    ;----------------------;


    ; call strchr(char* string, char c)
    ;----------------------;
    push dword[chr_to_find]
    push test_string
    call strchr
    add esp, 8

    push eax
    push print_string
    call printf
    add esp, 8
    ;----------------------;

    leave
    ret
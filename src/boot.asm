[BITS 16]
[ORG 0x7C00]

call clr

; print 
mov si, strt
call print
call newline
call newline

call show_prompt

jmp type_key

print:
    lodsb
    cmp al, 0
    je print_end
    mov ah, 0x0e
    int 0x10
    jmp print

print_end:
    ret

clr:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret

read_key:
    mov ah, 0x00
    int 0x16
    ret

type_key:
    call read_key
    cmp al, 13
    je enter_key

    cmp al, 8
    je backspace

    mov ah, 0x0e
    int 0x10

    jmp type_key

enter_key:
    call newline
    call show_prompt
    jmp type_key

newline:
    mov ah, 0x0e
    mov al, 13
    int 0x10

    mov al, 10
    int 0x10
    ret

backspace:
    mov ah, 0x0e
    mov al, 8
    int 0x10

    mov al, ' '
    int 0x10

    mov al, 8
    int 0x10

    jmp type_key

show_prompt:
    mov si, prompt
    call print
    ret

done:
    jmp $

strt db "cave os shell", 0
prompt db "> ", 0

times 510 - ($ - $$) db 0
dw 0xAA55

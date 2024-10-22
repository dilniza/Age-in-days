org 100h

age_input db 0
days_in_year dw 365
age_in_days dw 0

start:
    lea dx, input_prompt
    mov ah, 09h
    int 21h

    call get_input

    mov al, age_input
    mov ah, 0
    mov bx, days_in_year
    mul bx
    mov age_in_days, ax

    lea dx, result_prompt
    mov ah, 09h
    int 21h

    mov ax, age_in_days
    call print_number

    mov ah, 4ch
    int 21h

get_input:
    mov ah, 01h
    int 21h
    sub al, '0'
    mov age_input, al
    ret

print_number:
    push ax
    push bx
    push cx
    push dx

    xor cx, cx
    mov bx, 10

print_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne print_loop

print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits

    pop dx
    pop cx
    pop bx
    pop ax
    ret

result_prompt db 0dh, 0ah, 'Your age in days is: $', 0
input_prompt db 0dh, 0ah, 'Enter your age in years (0-9): $'

end start

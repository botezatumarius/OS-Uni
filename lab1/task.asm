org 0x7c00

mov dl, 34       

mov si, msg1     

print_char:
    inc dl
    mov bh, 0       
    mov ah, 02H     
    mov dh, 12       
    int 10h

    mov AH, 09h         
    mov AL, [si]        
    cmp dl, 41
    jge change_attribute
    mov bl, 0x3e       
    back:
    int 10h

    inc si             
    
    cmp byte [si], 0   
    jne print_char     


change_attribute:
    mov bl, 0x72
    cmp byte [si],0
    jne back


msg1 db "Marius Botezatu",0

times 1474560 - ($ - $$) db 0


org 0x7c00					; This is where the boot sector begins. Tells the assembler that the bootloader will be loaded at 0x7c00 address
	
; Method 1: ah 0eH: Write character as TTY
mov ah, 0eH ; teletype output
mov al, 'A' ; character to print
int 10h ; call BIOS

; Method 2: ah 0aH: Write character
mov bh, 0				; Set Video Page to 0
mov ah,02H              ; Move cursor to the second row
mov dh,1				; Set the row to 1
mov dl,0				; Set the column to 0 
int 10h

mov AH, 0aH     ; write character
mov AL, 'B'    ; 'B'
int 10h         ; call BIOS

; Method 3: ah 09H: Write character/attribute
mov bh, 0				; Set Video Page to 0
mov ah,02H              ; Move cursor to the third row
mov dh,2				; Set the row to 2
mov dl,0				; Set the column to 0 
int 10h

mov AH, 09h ; Write character/attribute at cursor position
mov AL, 'C' ; Character to write 
mov bl, 0x3e ; Attribute: yellow foreground cyan background
int 10h 

; Method 4: ax 1302H: Display Character/Attribute Cells
mov bh, 0				; Set Video Page to 0
mov cx, 5				; 5 characters to display
mov dh,3				; Set the row to 3
mov dl,0				; Set the column to 0 

mov ax, 0
mov es, ax					; ES:BP is the pointer to string
mov bp, msg1
mov ax, 1302H
int 10h

; Method 5: ax 1303H: Display Char/Attr Cells & Update Cursor
mov bh, 0					; Video page number
mov cx, 9					; String length
mov dh, 4					; Set the row to 4
mov dl, 0					; Set the column to 0

mov ax, 0
mov es, ax					; ES:BP is the pointer to string
mov bp, msg2

mov ax, 1303H
int 10h

; Method 6: ax 1300H: Display String
mov bh, 0 					; Video page number
mov ax, 0
mov es, ax 					; ES:BP is the pointer to string.
mov bp, msg3

mov bl, 0x78				; Attribute: gray text on white background
mov cx, 13					; String length
mov dh, 5					; Set the row to 5
mov dl, 0					; Set the column to 0

mov ax, 1300H
int 10h

; Method 7: ax 1301H: Display String & Update Cursor
mov bh, 0 					; Video page number.
mov ax, 0
mov es, ax 					; ES:BP is the pointer to string
mov bp, msg4

mov bl, 0x5a				; Attribute: bright green text on magenta background
mov cx, 11					; String length
mov dh, 6					; Set the row to 6
mov dl, 0					; Set the column to 0

mov ax, 1301H				
int 10h


msg1 db 'H', 0x04, 'e', 0x06, 'l', 0x0e, 'l', 0x02, 'o',0x09
msg2 db 'G', 0x0c, 'r', 0x0c, 'e', 0x04, 'e', 0x04, 't', 0x07, 'i', 0x03, 'n', 0x03, 'g', 0x0b, 's', 0x0b
msg3 db "Black & White"
msg4 db "Last method"

times 1474560 - ($ - $$) db 0
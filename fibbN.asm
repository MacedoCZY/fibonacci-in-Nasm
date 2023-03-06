%define userWR 644o  
%define append 2101o 
%define maxChars 92
%define openrw  102o 
;nasm -f elf64 fibbN.asm ; ld fibbN.o -o fibbN.x
section .data
    sec1 : db "N igual a 0, erro", 10
    secL1: equ $ - sec1
    primeiro : db "Valor de n = "
    primeiroL: equ $ - primeiro     
    sec : db "N muito grande, erro", 10
    secL: equ $ - sec
    arqN: db "fib(n).bin", 0
    arqN1: db "fib(nn).bin", 0
    ajuda: dq 0
	ajuda1: dq 0
	ajuda2: db 0
	ajuda3: dq 10
	arqD: dq 0
section .bss
    outP    : resb maxChars
    outPL   : resd 1
    inP     : resb maxChars
section .text
	global _start
_start:
    mov rax, 1
    mov rdi, 1 
    lea rsi, [primeiro]
    mov edx, primeiroL
    syscall
wr:
    mov rax, 0 
    mov rdi, 1
    lea rsi, [outP]
    mov edx, maxChars
    syscall
    mov [outPL], eax
chos:
	mov dl, [outP]
	cmp dl, 0x39
	je run
	cmp dl, 0x30
	je nul0
	cmp dl, 0x31
	je one
	cmp dl, 0x39
	jl more
more:
	mov bl, [outP+1]
	cmp bl, 0xa
	je openF
	mov bl, [outP+2]
	cmp bl, 0xa
	jne sugok
	cmp dl, 0x39
	jb openF
one:
	mov bl, [outP+1]
	cmp bl, 0xa
	je ultPul
	mov bl, [outP+2]
	cmp bl, 0xa
	jne sugok
	jle openF
run:
	mov bl, [outP+1]
	cmp bl, 0x32
	jg sugok
	mov bl, [outP+1]
	cmp bl, 0xa
	je openF
	mov bl, [outP+2]
	cmp bl, 0xa
	jne sugok
openF:
	xor rcx, rcx
	mov cl, [outP]
	sub cl, 0x30
	mov al, [outP+1]
	cmp al, 0xa
	je getOut
	sub al, 0x30
	imul cx, [ajuda3]
	mov [ajuda2], cx
	add [ajuda2], al
	jmp rriu
getOut:
	mov [ajuda2], cx
rriu:
	mov bx, [ajuda2]
	dec bx
	mov cx, [ajuda2]
	sub cx, bx
	mov r11, 0x0 
	mov r12, 0x1  
init1:
	cmp cx, [ajuda2]
	jge pullOn
intu: 
	mov [ajuda], r11
	add [ajuda], r12
	mov [ajuda1], r12
	mov r11, [ajuda1]
	mov r12, [ajuda]
	mov [inP], r12
	inc cx
	jmp init1
ultPul:
	mov r13, 0x1
	mov [inP], r13
pullOn:
	mov r8b, [outP]
	mov [arqN+4], r8b
	mov r8b, [outP+1]
	cmp r8b, 0xa
	je dig
	mov r9b, [outP]
	mov [arqN1+4], r9b
	mov r9b, [outP+1]
	mov [arqN1+5], r9b
	jmp dig1
dig:
    mov rax, 2         
    lea rdi, [arqN] 
    mov rsi, openrw     
    mov rdx, userWR    
    syscall
    mov [arqD], rax
    jmp wart
dig1:
    mov rax, 2        
    lea rdi, [arqN1] 
    mov rsi, openrw  
    mov rdx, userWR    
    syscall
    mov [arqD], rax
wart:
    mov rax, 1        
    mov rdi, [arqD] 
    lea rsi, [inP]
    mov rdx, 9
    syscall
acll:
    mov rax, 3  
    mov rdi, [arqD]
    syscall
	jmp fim
sugok:
    mov rax, 1
    mov rdi, 1  
    lea rsi, [sec]
    mov edx, secL
    syscall
    jmp fim
nul0:
    mov rax, 1
    mov rdi, 1  
    lea rsi, [sec1]
    mov edx, secL1
    syscall
    jmp fim
fim:
    mov rax, 60
    mov rdi, 0
    syscall

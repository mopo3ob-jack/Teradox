%include "smoothstep.inc"

section .data

scanFormat db "%lf", 0
printFormat db "smoothstep(%f, %f, %f) -> %f", 10, 0

section .bss

x resq 1
a resq 1
b resq 1

section .text

; int scanf(const char* format, ...);
extern scanf
; int printf(const char* fmt, ...);
extern printf

global _start
_start:
	mov rdi, scanFormat
	mov rsi, x  ; Move in the pointer x, not dereferenced like [x]
	call scanf

	mov rdi, scanFormat
	mov rsi, a
	call scanf

	mov rdi, scanFormat
	mov rsi, b
	call scanf

	movsd xmm0, [x]
	movsd xmm1, [a]
	movsd xmm2, [b]
	call smoothstep
	
	mov rdi, printFormat
	movsd xmm3, xmm0
	movsd xmm0, [x]
	movsd xmm1, [a]
	movsd xmm2, [b]
	call printf

	mov rax, 60
	mov rdi, 0
	syscall

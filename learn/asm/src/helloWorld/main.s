; https://www.nasm.us/doc/nasmdoc7.html#section-7.3
section .data ; Initialized data (Strings always go here in C)

; https://awjunaid.com/assembly/how-are-labels-used-in-assembly-language-programming/
; https://www.nasm.us/doc/nasmdoc3.html#section-3.2.1 
myString:
	db "Hello World!", 10, 0
myStringEnd:

; https://www.nasm.us/doc/nasmdoc3.html#section-3.2.4
myStringLength equ (myStringEnd - myString)

section .bss ; Uninitialized data

section .text ; Assembly Instructions

; https://www.nasm.us/doc/nasmdoc7.html#section-7.5
; The extern keyword means "to import a symbol" so that we can use variables
; and functions from other binaries. In this case, printf lives in libc.so.6
extern printf

; https://www.nasm.us/doc/nasmdoc7.html#section-7.7
; The global keyword means "to export a symbol" such that other binaries given
; to the linker can interact with this program. One such program is the Linux
; Kernel, which loads this program into memory and executes the _start function
global _start
; The terminology for the start of a program is known as the "entry point"
_start:
	; printf(myString);
	mov rdi, myString ; rdi = myString (1st arg)
	call printf
	
	; sys_exit(0);
	mov rax, 60 ; rax = 60
	mov rdi, 0 ; rdi = 0 (1st arg)
	; This interrupt escapes normal execution and transfers the program control
	; to the kernel loaded to the CPU.
	syscall

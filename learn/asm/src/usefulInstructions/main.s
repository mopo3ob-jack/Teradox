%macro printESI 1
	mov rdi, %1
	call printf
%endmacro

section .data

formatLEA db "lea esi, [ebx + ecx * 4] -> %d", 10, 0
formatXOR db "xor esi, esi -> %d", 10, 0
formatADC db "add al, 100 ; adc ah, 0 -> %d", 10, 0
formatSBB db "sub al, 128 ; sbb ah, 128 -> %d", 10, 0

section .text

extern printf

global _start:
_start:

; LEA - Load Effective Address
; Rather than moving the memory specified at the location rdi + rsi * 4,
; LEA loads rax with the value inside the brackets. It is a way to calculate the
; operand address without accessing the memory it references. It is also commonly
; used by compiliers to do multiple operations at the same time. In this case,
; we have done one multiply and one addition with 3 registers and one instruction.
	mov ebx, 10
	mov ecx, 3
	lea esi, [ebx + ecx * 4]
	printESI formatLEA

; XOR - bitwise eXclusive OR
; When you xor an operand with itself, it sets the value of that operand to zero.
	xor esi, esi
; The line above is more optimal because the CPU only has to read the opcode rather
; than also loading in the zero.
	mov esi, 0
	printESI formatXOR

; ADC - ADd with Carry
; The normal ADD instruction operates like this:
; 	DEST += SRC
; However, ADC adds the carry flag as well:
; 	DEST += SRC + C
; The carry flag is a 1 bit number on the CPU that will be set to 1 should the
; previous instruction overflow. For example:
	mov eax, 400
	add al, 100
; After this operation, we can continue to add larger numbers with small registers.
	adc ah, 0
; The correct result is obtained with extra steps. This is how to add numbers larger
; than processor register size. 
	mov esi, eax
	printESI formatADC

; SBB - SuBtract with Borrow
; This is the ADC analogue to SUB. On some processors this is instead called SBC.
; SUB
; 	DEST += -SRC
; SBB
;   DEST += -(SRC + C)
	mov eax, 512
	sub al, 128
	sbb ah, 1
; We are subtracting 0x200(512) first by 0x80(128) and then by  0x100(1 << 8)
	mov esi, eax
	printESI formatSBB

	; sys_exit(0);
	mov rax, 60
	mov rdi, 0
	syscall

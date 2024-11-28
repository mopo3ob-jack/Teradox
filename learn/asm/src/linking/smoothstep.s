section .text

; MOVSD - MOVe Single scaler Double to lowest qword of an SSE register.
; xmm registers are special registers that have the ability to perform floating point operations.
; Because they are 256 bits in size, you need a special instruction to load data into them.

global smoothstep
; double smoothstep(double x, double a, double b);
smoothstep:
; x = (x - a) / (b - a);
	subsd xmm0, xmm1    ; x -= a
	subsd xmm2, xmm1    ; b -= a
	divsd xmm0, xmm2    ; x /= b
;
	movsd xmm1, [.zero]
	movsd xmm2, [.one]
	ucomisd xmm0, xmm1
	ja .clampOne
; if (x < 0.0f) {
	movsd xmm0, xmm1
	movsd xmm0, [.zero]
	jmp .clampEnd
.clampOne:
	ucomisd xmm0, xmm2
	jb .clampEnd
; } else if (x > 1.0f) {
	movsd xmm0, xmm2
; }
.clampEnd:
; x = x  * x * (3.0f - 2.0f * x);
	movsd xmm1, [.two]
	movsd xmm2, [.three]
	mulsd xmm1, xmm0    ; 2.0f * x
	subsd xmm2, xmm1    ; 3.0f - (2.0f * x)
	mulsd xmm0, xmm0    ; x * x
	mulsd xmm0, xmm2    ; x * x + (3.0f - 2.0f * x)

	ret

; The MOVSD instruction doesn't accept immediates, so you have to pass a pointer to a constant.
; Typically, you should define data in data or bss. However, because these are read-only, it is perfectly valid
; to place them with code. Some systems may make the text section read-only to prevent vulnerabilities. There
; are certain hardware differences for code and data memory such that code can be loaded at faster rate. That's
; why it may be beneficial to encode constants in this segment.
.zero:
	dq 0.0
.one:
	dq 1.0
.two:
	dq 2.0
.three:
	dq 3.0

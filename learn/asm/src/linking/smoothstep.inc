%ifndef SMOOTHSTEP_INC
%define SMOOTHSTEP_INC

; Floating point arguments are stored in xmm registers starting at xmm0.
; Floating point return values are stored in xmm0.
; double smoothstep(double x, double a, double b);
extern smoothstep

%endif

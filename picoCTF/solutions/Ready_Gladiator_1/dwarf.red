;redcode
;assert 1
add #4, 3   ; adds the direct address 4, 3 and stores the result in the B field of 3
mov 2, @2   ; copies the instruction at 2 to the indirect address of 2 (wherever the B field of 2 points to)
jmp -2     ; jumps back 2 instructions, so as to avoid the dat which ends the process
dat  #0, #0 ; dat which is cloned over and over
end

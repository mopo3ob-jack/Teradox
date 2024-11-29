;redcode
;assert 1

jmp 0, <-5 ; jumps to 0, predecrements the address pointed to by the B field of -5
           ; This will eventually decrement the B field of the imp's `mov 0 1` instruction
           ; causing it to run into fail to copy its instruction and run into a `dat 0 0`
           ; right afterwards.

end

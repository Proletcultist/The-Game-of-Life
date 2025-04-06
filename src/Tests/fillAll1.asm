# Main program section
rsect main

include matrixLib.h

main>

	ldi r0, 0
	ldi r1, 0
	ldi r2, 31
	ldi r3, 31

	jsr setRectTo1

	rts

end

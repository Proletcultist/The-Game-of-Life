# Try to insert first default template

rsect main

include matrixLib.h

main>

	ldi r0, 0
	ldi r1, 5
	ldi r2, 29
	jsr insertTemplate

	rts

end

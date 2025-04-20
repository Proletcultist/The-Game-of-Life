# Try to insert first default template

rsect main

include matrixLib.h

main>

	ldi r0, 0
	ldi r1, 0
	ldi r2, 0
	jsr insertTemplate

	ldi r0, 1
	ldi r1, 0
	ldi r2, 0
	ldi r3, 2
	ldi r4, 2
	jsr saveTemplate

	ldi r0, 1
	ldi r1, 5
	ldi r2, 0
	jsr insertTemplate

	rts

end

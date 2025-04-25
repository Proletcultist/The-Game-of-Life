rsect main

include matrixLib.h

main>
	ldi r0, 0
	ldi r1, 0
	ldi r2, 31
	ldi r3, 31

	jsr setRectTo1

	ldi r0, 0
	ldi r1, 0
	ldi r2, 15
	ldi r3, 15

	ldi r4, 55
	ldi r5, 5456
	ldi r6, 545

	jsr setRectTo0

	ldi r0, 15
	ldi r1, 15
	ldi r2, 31
	ldi r3, 31

	jsr setRectTo0

	rts


end.

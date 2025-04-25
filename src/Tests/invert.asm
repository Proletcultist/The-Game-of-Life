rsect main

include matrixLib.h

main>
	ldi r0, 0
	ldi r1, 0

	jsr invert

	ldi r0, 1
	ldi r1, 0

	jsr invert

	ldi r0, 0
	ldi r1, 0

	jsr invert

	rts

end.

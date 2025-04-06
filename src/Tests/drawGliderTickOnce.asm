# Draws glider and do one step

rsect main

include matrixLib.h

main>
	ldi r0, 3
	ldi r1, 0

	jsr setTo1

	ldi r0, 4			
	ldi r1, 1

	jsr setTo1

	ldi r0, 2
	ldi r1, 2
	ldi r2, 4
	ldi r3, 2

	jsr setRectTo1

	ldi r0, 0b0000000000001100

	jsr setSurv

	ldi r0, 0b0000000000001000

	jsr setBorn

	jsr stepOnce

	rts

end

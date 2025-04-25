rsect main

include matrixLib.h

main>

	ldi r0, 0
	ldi r1, 0

	jsr setTo1
	
	jsr clear

	ldi r0, 0
	ldi r1, 0
	ldi r2, 0

	jsr insertTemplate

	ldi r0, 0b0000000000001100

	jsr setSurv

	ldi r0, 0b0000000000001000

	jsr setBorn

	jsr startGame

	rts

end

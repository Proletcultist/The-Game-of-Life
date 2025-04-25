
rsect main

include matrixLib.h

main>
	
	ldi r0, 1
	ldi r1, 9

	jsr setTo1

	ldi r0, 2
	ldi r1, 9

	jsr setTo1

	rts

end.

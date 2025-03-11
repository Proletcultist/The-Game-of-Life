# Main program section
rsect main

setTo1: ext
setTo0: ext
startGame: ext
pauseGame: ext
setRules: ext
setRectTo1: ext
clear: ext

main>
	ldi r0, 0xff00
	stsp r0

	ei

	ldi r0, 5
	ldi r1, 0

	jsr setTo1
# Testing setRectTo1

	ldi r0, 0
	ldi r1, 0
	ldi r2, 31
	ldi r3, 0

	jsr setRectTo1

# Testing setTo0
	
	ldi r0, 5
	ldi r1, 0

	jsr setTo0
# End of test

	ldi r0, 6
	ldi r1, 1

	jsr setTo1
	
	ldi r0, 6
	ldi r1, 2

	jsr setTo1

	ldi r0, 5
	ldi r1, 2

	jsr setTo1

	ldi r0, 4
	ldi r1, 2

	jsr setTo1

	ldi r0, 2
	ldi r1, 3
	ldi r2, 3
	

	jsr setRules

	jsr startGame	

	halt
end

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

	jsr setRules

	jsr startGame	

	halt
end

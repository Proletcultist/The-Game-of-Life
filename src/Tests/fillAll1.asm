# Main program section
rsect main

setTo1: ext
setTo0: ext
startGame: ext
pauseGame: ext
setSurv: ext
setBorn: ext
setRectTo1: ext
speedUp: ext
speedDown: ext
setSpeed: ext
clear: ext

main>

	ldi r0, 0
	ldi r1, 0
	ldi r2, 31
	ldi r3, 31

	jsr setRectTo1

	rts

end

# Draws glider and runs game on default speed

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

		jsr startGame

		rts

end

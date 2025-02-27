# Main program section
rsect main

# Draws glider and run game with standart rules
main>
	ldi r0, 0xff80
	ldi r1, 0b0000010000000000
	stw r0, r1

	ldi r0, 0xff84
	ldi r1, 0b0000001000000000
	stw r0,r1
	
	ldi r0, 0xff88
	ldi r1, 0b0000111000000000
	stw r0, r1

	ldi r0, 0xff7e
	ldi r1, 0b0001001100110010
	stw r0, r1

	halt
end

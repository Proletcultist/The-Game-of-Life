# Section with matrix driver functions
rsect matrixDriver

mulUns: ext

mtx: dc 0xff80
state: dc 0xff7e

rowscoords: dc 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120, 124

offsetmasks: dc 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768

# set_to_1(x,y) x in r0, y in r1
setTo1>
	ldi r2, 16 
	if
		cmp r0, r2
	is lo
		ldi r2, 0
		add r0, -15
		neg r0
	else
		ldi r2, 2
		add r0, -31
		neg r0
	fi

# Now r2 - x address, r0 - word offset
	ldi r6, rowscoords
	shl r1
	ldw r6, r1, r6

	add r6, r2
# Now r2 - matrix address offset

	ldi r3, mtx
	ldw r3, r3
	ldw r2, r3, r4

	ldi r1, offsetmasks
	shl r0
	ldw r1, r0, r1

	or r1, r4

	stw r2, r3, r4

	rts

startGame>
	ldi r0, state
	ldw r0, r0
	ldw r0, r1

	ldi r2, 4096
	or r2, r1

	stw r0, r1

	rts

# r0 - die1, r1 - die2, r2 - resp
setRules>
	ldi r3, state
	ldw r3, r3
	ldw r3, r4

	ldi r5, 0b1111000000000000
	and r5, r4

	shl r1	
	shl r1
	shl r1
	shl r1

	shl r2
	shl r2
	shl r2
	shl r2
	shl r2
	shl r2
	shl r2
	shl r2

	add r0, r1
	add r1, r2
	add r2, r4

	stw r3, r4

	rts

end

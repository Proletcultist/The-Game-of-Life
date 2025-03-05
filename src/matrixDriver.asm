# Section with matrix driver functions
rsect matrixDriver

mulUns: ext

mtx: dc 0xff80
state: dc 0xff7e

rowscoords: dc 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120, 124

offsetmasks: dc 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536

# set_to_1(x,y) x in r0, y in r1
setTo1>
	if
		cmp r0, 16
	is lo
		ldi r2, 0
		sub r0, 15
		neg r0
	else
		ldi r2, 2
		sub r0, 31
		neg r0
	fi

# now r2 - x address, r0 - word offset
	ldi r3, rowscoords
	shl r1
	ldw r3, r1, r3

	add r3, r2
# now r2 - matrix address

	ldi r3, mtx
	ldw r3, r3
	ldw r2, r3, r4

	ldi r1, offsetmasks
	shl r0
	ldw r1, r0, r1

	or r1, r4

	stw r2, r3, r4

	rts

setTo0>
	if
		cmp r0, 16
	is lo
		ldi r2, 0
		sub r0, 15
		neg r0
	else
		ldi r2, 2
		sub r0, 31
		neg r0
	fi

# now r2 - x address, r0 - word offset
	ldi r3, rowscoords
	shl r1
	ldw r3, r1, r3

	add r3, r2
# now r2 - matrix address

	ldi r3, mtx
	ldw r3, r3
	ldw r2, r3, r4

	ldi r1, offsetmasks
	not r1
	shl r0
	ldw r1, r0, r1

	and r1, r4

	stw r2, r3, r4

	rts

# r0=x1, r1=y1, r2=x2, r3=y2
setRectTo1>
	
	

startGame>
	ldi r0, state
	ldw r0, r0
	ldw r0, r1

	ldi r2, 4096
	or r2, r1

	stw r0, r1

	rts

pauseGame>
	ldi r0, state
	ldw r0, r0
	ldw r0, r1

	ldi r2, 61440

	and r2, r1

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

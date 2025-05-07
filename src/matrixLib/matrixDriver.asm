asect 0xff80
mtx>
asect 0xff7e
state1:
asect 0xff7c
state2:
asect 0xff76
stepaddres:
asect 0xff74
clearaddres:

# Section with matrix driver functions
rsect matrixDriver

uart: ext
templates: ext

rowscoords> dc 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120, 124
offsetmasks> dc 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0

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
	ldw r2, r3, r4

	ldi r1, offsetmasks
	shl r0
	ldw r1, r0, r1
	not r1

	and r1, r4

	stw r2, r3, r4

	rts

# r0=x1, r1=y1, r2=x2, r3=y2
setRectTo1>
	if 
		cmp r0, 16
	is lo
		sub r0, 16
		neg r0
		shl r0
		ldi r4, offsetmasks
		ldw r4, r0, r0
		dec r0

		if
			cmp r2, 16
		is lo
			sub r2, 15
			neg r2
			shl r2
			ldw r4, r2, r2
			dec r2
			not r2

			and r2, r0
			ldi r2, 0	
		else
			sub r2, 31
			neg r2		
			shl r2
			ldw r4, r2, r2
			dec r2
			not r2
		fi
	else
		ldi r4, offsetmasks
		sub r2, 31
		neg r2		
		shl r2
		ldw r4, r2, r2
		dec r2
		not r2

		sub r0, 32
		neg r0
		shl r0
		ldw r4, r0, r0
		dec r0
				
		and r0, r2
		ldi r0, 0
	fi	


	# in r0 first word mask, in r2 second word mask

	ldi r4, rowscoords
	shl r1
	ldw r4, r1, r1

	shl r3
	ldw r4, r3, r3

	ldi r4, mtx
	while 
		cmp r3, r1
	stays hs
		ldw r4, r1, r5
		or r0, r5
		stw r4, r1, r5
		add r1, 2

		ldw r4, r1, r5
		or r2, r5
		stw r4, r1, r5
		add r1, 2
	wend

	rts
	
# r0=x1, r1=y1, r2=x2, r3=y2
setRectTo0>
	if 
		cmp r0, 16
	is lo
		sub r0, 16
		neg r0
		shl r0
		ldi r4, offsetmasks
		ldw r4, r0, r0
		dec r0

		if
			cmp r2, 16
		is lo
			sub r2, 15
			neg r2
			shl r2
			ldw r4, r2, r2
			dec r2
			not r2

			and r2, r0
			ldi r2, 0	
		else
			sub r2, 31
			neg r2		
			shl r2
			ldw r4, r2, r2
			dec r2
			not r2
		fi
	else
		ldi r4, offsetmasks
		sub r2, 31
		neg r2		
		shl r2
		ldw r4, r2, r2
		dec r2
		not r2

		sub r0, 32
		neg r0
		shl r0
		ldw r4, r0, r0
		dec r0
				
		and r0, r2
		ldi r0, 0
	fi	

	not r0
	not r2
	# in r0 first word mask, in r2 second word mask

	ldi r4, rowscoords
	shl r1
	ldw r4, r1, r1

	shl r3
	ldw r4, r3, r3

	ldi r4, mtx
	while 
		cmp r3, r1
	stays hs
		ldw r4, r1, r5
		and r0, r5
		stw r4, r1, r5
		add r1, 2

		ldw r4, r1, r5
		and r2, r5
		stw r4, r1, r5
		add r1, 2
	wend

	rts

startGame>
	ldi r0, state2
	ldw r0, r1

	ldi r2, 0b0000001000000000
	or r2, r1

	stw r0, r1

	rts

pauseGame>
	ldi r0, state2
	ldw r0, r1

	ldi r2, 0b1111110111111111

	and r2, r1

	stw r0, r1

	rts

# r0 - surv, all bits, except 0-8, should be zero!!
setSurv>
	ldi r1, state1
	ldw r1, r2

	ldi r3, 0b1111111000000000
	and r3, r2
	or r0, r2

	stw r1, r2
	
	rts

# r0 - born, all bits, except 0-8, should be zero!!
setBorn>
	ldi r1, state2
	ldw r1, r2

	ldi r3, 0b1111111000000000
	and r3, r2
	or r0, r2

	stw r1, r2
	
	rts

clear>
	ldi r0, clearaddres
	
	stw r0, r0 

	rts

speedDown>
	ldi r0, state2
	ldw r0, r1
	ldi r2, 0b0000010000000000
	add r2, r1 			# Assume, what there is no significant data after 12th bit
	
	stw r0, r1	

	rts
speedUp>
	ldi r0, state2
	ldw r0, r1
	ldi r2, 0b1111110000000000
	add r2, r1 			# Assume, what there is no significant data after 12th bit
	
	stw r0, r1	

	rts

# Speed in r0
setSpeed>
	ldi r1, state2
	ldw r1, r2

	ldi r3, 0b1111001111111111
	and r3, r2

	shl r0	
	shl r0	
	shl r0	
	shl r0	
	shl r0	
	shl r0	
	shl r0	
	shl r0	
	shl r0	
	shl r0	

	or r0, r2

	stw r1, r2

	rts

stepOnce>
	ldi r0, stepaddres
	stb r0, r0

	rts

# r0 - x, r1 - y
invert>
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
	ldw r2, r3, r4

	ldi r1, offsetmasks
	shl r0
	ldw r1, r0, r1

	xor r1, r4

	stw r2, r3, r4

	rts

# Outputs: r0 - surv, r1 - born
getRules>
	ldi r1, state2
	ldw r1, r1
	ldi r0, 0b0000000111111111
	and r1, r0, r1

	ldi r0, state1
	ldw r0, r0
	ldi r2, 0b0000000111111111
	and r2, r0, r0

	rts

getTemplates>

	ldi r0, templates
	ldi r5, uart
	ldi r6, 0x0D		# CR
	stb r5, r6
	ldi r6, 0x0A		# LF
	stb r5, r6
	ldi r6, 0x30		# '0'
	while
		ldi r4, 0xfee0
		cmp r0, r4
	stays lo
while_start:
		stb r5, r6
		save r6
		ldi r4, 0x3a	# ':'
		stb r5, r4
		ldi r4, 0x0D	# CR
		stb r5, r4
		ldi r4, 0x0A	# LF
		stb r5, r4

		ldw r0, r1

		if 
			tst r1
		is z
			# Specified slot is empty
			ldi r4, 130
			add r0, r4, r0
			pop r6
			inc r6

			ldi r4, 0xfee0
			cmp r0, r4
			blo while_start

			br while_end
		fi

		move r0, r2
		add r2, 2

	# r0/r2 - first word of template, r3/r1 - header
		
		move r1, r3
		ldi r4, 0b0000000000111111	
		and r4, r1, r1

		shr r3
		shr r3
		shr r3
		shr r3
		shr r3
		shr r3

		save r0
	# r1 - width, r2 - read addr, r3 - height, r5 - uart

		initBitReader r4, r6, r2	

		while
			cmp r3, 0
		stays hi
			ldi r7, 0
			while
				cmp r1, r7
			stays hi
				readBit
				
				if
				is cs
					ldi r0, 0x58	# 'X'
					stb r5, r0
				else
					ldi r0, 0x2e	# '.'
					stb r5, r0
				fi	
				inc r7
			wend
			ldi r0, 0x0D	# CR
			stb r5, r0
			ldi r0, 0x0A	# LF
			stb r5, r0
			dec r3
		wend

		destroyBitReader

		ldi r0, 0x0D	# CR
		stb r5, r0
		ldi r0, 0x0A	# LF
		stb r5, r0


		restore
		ldi r4, 130
		add r0, r4, r0
		restore
		inc r6
	wend
while_end:

	rts

setBoundsMode>
	ldi r0, state1
	ldw r0, r1
	ldi r2, 0b1111110111111111

	and r2, r1, r1

	stw r0, r1

	rts

setToroidalMode>
	ldi r0, state1
	ldw r0, r1
	ldi r2, 0b0000001000000000

	or r2, r1, r1

	stw r0, r1

	rts
	
end

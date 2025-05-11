asect 0xfc56
templates>
# First initial template - glider
dc 0b0000000011000011, 0b0100011110000000
align 0xfcd8
dc 0b0000000100000101, 0b0011011011111100, 0b1100000000000000
align 0xfd5a
dc 0b0000000010000011, 0b0101110000000000
align 0xfee0

rsect matrixTemplates

include mathLib.h
include strLiterals.h

mtx: ext
rowscoords: ext
offsetmasks: ext

writeToUART: ext

# r0 - slot number, r1 - x, r2 - y
insertTemplate>
	
	save r1
	save r2

	ldi r1, 130 	# 130 - size of one slot

	jsr uMult

	restore
	restore

	ldi r3, templates
	add r3, r0, r0
	ldw r0, r3

	if 
		tst r3
	is z
		# Specified slot is empty
		ldi r0, error_slot_is_empty
		jsr writeToUART

		ldi r2, -1

		rts
	fi

	add r0, 2

# r0 - first word of template, r1 - x, r2 - y, r3 - header
	
	move r3, r4
	ldi r5, 0b0000000000111111	
	and r5, r3, r3

	shr r4
	shr r4
	shr r4
	shr r4
	shr r4
	shr r4

	add r3, r1, r3
	add r4, r2, r4	

	dec r3
	dec r4

	if 
		cmp r3, 31
	is hi
		# Template does not fit by width
		ldi r0, error_template_too_big_x
		jsr writeToUART

		ldi r2, -1

		rts
	fi	
	if 
		cmp r4, 31
	is hi
		# Template does not fit by height
		ldi r0, error_template_too_big_y
		jsr writeToUART

		ldi r2, -1

		rts
	fi

	ldi r5, rowscoords
	shl r2	
	ldw r5, r2, r2

	shl r4
	ldw r5, r4, r4

# r0 - first wird of template, r1 - x1, r2 - start addr, r3 - x2, r4 - end addr

	move r3, r5
	sub r5, r1, r5
	inc r5
	
	push r5		# Stored amount of bits per row

	ldi r5, 31
	sub r5, r3, r5

	push r5 	# Stored offset of template (amount of shl needed to place it right)	


	if 
		cmp r1, 16
	is lo
		sub r1, 16
		neg r1
		shl r1
		ldi r5, offsetmasks
		ldw r5, r1, r1
		dec r1
		
		if 
			cmp r3, 16
		is lo
			sub r3, 15
			neg r3
			shl r3
			ldw r5, r3, r3
			dec r3
			not r3

			and r3, r1
			ldi r3, 0
		else
			sub r3, 31
			neg r3
			shl r3
			ldw r5, r3, r3
			dec r3
			not r3
		fi
	else
		ldi r5, offsetmasks
		sub r3, 31
		neg r3
		shl r3
		ldw r5, r3, r3
		dec r3
		not r3

		sub r1, 32
		neg r1
		shl r1
		ldw r5, r1, r1
		dec r1

		and r1, r3
		ldi r1, 0
	fi

	not r3
	not r1
		
	push r3		# Stored second word clear mask	
	push r1		# Stored first word clear mask

	push r4		# Stored last addr

	ldsp fp
# Stack structure 
# - Last addr
# - First word clear mask
# - Second word clear mask
# - Offset
# - Bit amount

# r0 - first template word, r2 - y1, r4 - y2, fp - sp

	initBitReader r5, r6, r0	

# free - r1, r3

	while
		cmp r4, r2
	stays hs
		# r1 - first template mask word, r3 - second
		clr r1
		clr r3
		lsw r4, 8
		while
			tst r4
		stays nz
			# Shift r3 left into r1
			shl r1
			if
				shl r3
			is cs
				inc r1
			fi

			readBit
			
			if
			is cs
				inc r3
			fi	
			dec r4
		wend

		lsw r4, 6
		while
			tst r4
		stays nz
			shl r1
			if
				shl r3
			is cs
				inc r1
			fi
			dec r4
		wend	

		push r3	
		push r1

		ldi r4, mtx
		ldw r2, r4, r1

		lsw r3, 2
		and r3, r1, r1

		pop r3	
		or r3, r1, r1

		stw r2, r4, r1

		add r2, 2

		ldw r2, r4, r1

		lsw r3, 4
		and r3, r1, r1

		pop r3	
		or r3, r1, r1

		stw r2, r4, r1

		add r2, 2

		lsw r4, 0
	wend

	destroyBitReader

	addsp 10

	rts

# r0 - slot num, r1 - x1, r2 - y1, r3 - x2, r4 - y2
saveTemplate>
	save r1
	save r2

	ldi r1, 130 	# 130 - size of one slot

	jsr uMult

	restore
	restore

	ldi r5, templates
	add r5, r0, r0

	sub r4, r2, r5
	inc r5

	shl r5	
	shl r5
	shl r5	
	shl r5	
	shl r5	
	shl r5	

	sub r3, r1, r6
	inc r6

	add r6, r5, r5

	stw r0, r5	# Stored header in templates array

	add r0, 2

	push r6		# Stored bits per row

	push r1 	# Stored offset

	ldi r5, rowscoords
	shl r2
	ldw r5, r2, r2

	shl r4
	ldw r5, r4, r4

	push r4		# Stored last addr

	ldsp fp

	initBitWriter r1, r3, r0
# Stack struct:
# - last addr
# - offset
# - bits per row
# Free - r5, r6	

	while
		cmp r4, r2
	stays hs
		ldi r4, mtx
		ldw r4, r2, r5

		add r2, 2

		ldw r4, r2, r6

		add r2, 2

		lsw r4, 2

		while
			tst r4
		stays nz
			shl r5

			if
				shl r6
			is cs
				inc r5
			fi	

			dec r4
		wend	

		lsw r4, 4

		while
			tst r4
		stays nz
			if
				shl r5
			is cs
				writeBit1
			else
				writeBit0
			fi

			if
				shl r6
			is cs
				inc r5
			fi

			dec r4
		wend

		lsw r4, 0
	wend

	destroyWriter

	addsp 6
		
	rts
end.

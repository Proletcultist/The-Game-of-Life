# Macroses for reading stream of bits from specified addres in memory

# Choose registers for buffering, pointer and for counting, set start address
macro initStreamRW/4
	ldi $1, $3
	ldi $2, 0
	ldi $0, 0

	mpush $0
	mpush $1
	mpush $2
mend

# Next bit will be placed in C
macro getNextBit
	mpop cnt
	mpop ptr
	mpop buff
	
	if 
		tst cnt
	is z
		ldw ptr, buff
		inc ptr
		inc ptr

		ldi cnt, 16	
	else

	fi	

	dec cnt
	shl buff

	mpush buff
	mpush ptr
	mpush cnt
mend

macro add1bit
	mpop cnt
	mpop ptr
	mpop buff

	if
		cmp cnt, 16
	is eq
		stw ptr, buff
		inc ptr
		inc ptr

		ldi buff, 0					
		ldi cnt, 0
	else

	fi	

	shl buff
	inc buff
	inc cnt

	mpush buff
	mpush ptr
	mpush cnt
mend

macro add0bit
	mpop cnt
	mpop ptr
	mpop buff

	if
		cmp cnt, 16
	is eq
		stw ptr, buff
		inc ptr
		inc ptr

		ldi buff, 0					
		ldi cnt, 0
	else

	fi	

	shl buff

	mpush buff
	mpush ptr
	mpush cnt
mend

macro flushBitstream
	mpop cnt
	mpop ptr
	mpop buff

	if 
		tst cnt
	is nz
		while
			cmp cnt, 16
		stays nz
			shl buff
			inc cnt
		wend

	else

	fi

			
	mpush buff
	mpush ptr
	mpush cnt
mend

macro destroyStreamRW
	mpop
	mpop
	mpop
mend

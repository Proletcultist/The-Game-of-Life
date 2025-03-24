asect 0xff7a
uart:

asect 0xfeb4
buf: ds 30

# Exception handlers section
rsect exc_handlers

default_handler>
	ldi r3, 404
    halt

sample_1_int>
	ldi r0, 588
	rti

sample_2_int>
	ldi r0, uart
	ldi r1, buf
	ldi r2, 10

	ldb r0, r3
	while
		cmp r3, r2
	stays ne
		stb r1, r3
		ldb r1, r6
		ldb r0, r3
		inc r1
	wend
	clr r2
	dec r1
	stb r1, r2
	ldb r1, r6

	ldi r0, 0xff78
	ldb r0, r0

	rti

end

asect 0xff7a
uart:

asect 0xfee1
buf: ds 31

rsect uartUtils

include strLiterals.h

readFromUART>
    ldi r0, uart
	ldi r1, buf

	ldb r0, r2
	while
		cmp r2, 10
	stays ne
		ldi r3, 0xff00
		if
            cmp r1, r3
        is eq
            #print error
			ldi r0, error_many_chars
			jsr writeToUART

			ldi r0, uart
			jsr freeUART

			# address for completing line reading
			ldi r0, 0xff78
			ldb r0, r0

			ldi r0, str_input
			jsr writeToUART

			ldi r0, -1
		    rts
        fi
		stb r1, r2
		ldb r0, r2
		inc r1
	wend

	ldi r2, 0
	dec r1
	stb r1, r2

	# address for completing line reading
	ldi r0, 0xff78
	ldb r0, r0
    rts

#r0 - pointer for str
writeToUART>
    ldi r1, uart
    ldb r0, r2
    while
        cmp r2, 0
    stays ne
        stb r1, r2
        inc r0
        ldb r0, r2
    wend
    rts

#r0 - pointer for UART buf
freeUART:
    ldb r0, r1
    while
        cmp r1, 10
    stays ne
        ldb r0, r1
    wend
    rts

end

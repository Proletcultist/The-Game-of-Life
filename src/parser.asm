asect 0xfee1
buf:

rsect parser

setTo1: ext

skipSpaces: ext
strncmp: ext
readUInt: ext

set1: ext

parse>
    ldi r0, buf
	jsr skipSpaces

	ldi r1, set1
	ldi r4, 2
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readUInt
        move r1, r6

        jsr skipSpaces

        jsr readUInt
        move r1, r7

        move r6, r0
        move r7, r1
        jsr setTo1

        rts
    fi

end
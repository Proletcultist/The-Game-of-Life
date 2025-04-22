asect 0xfee1
buf:

rsect parser

include matrixLib.h
include parserUtils.h
include strLiterals.h

parse>
    ldi r0, buf
    jsr skipSpaces


	ldi r1, str_set1
	ldi r4, 2
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readUInt
        push r1

        jsr skipSpaces

        jsr readUInt
        push r1

        pop r1
        pop r0
        jsr setTo1

        rts
    fi

    #print error "incorrect command"
    ldi r6, 405
    rts

end
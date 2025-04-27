asect 0xfee1
buf:

rsect parser

include matrixLib.h
include parserUtils.h
include strLiterals.h
writeToUART: ext

parse>
    #setTo1
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
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r3

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r5

        jsr skipSpaces

        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        # move r3, r0
        # move r5, r1
        # jsr setTo1
        ldi r0, str_loadx
        jsr writeToUART

        rts
    fi


    #setTo0
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_set0
	ldi r4, 2
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r3

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r5

        jsr skipSpaces

        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        move r3, r0
        move r5, r1
        jsr setTo0

        rts
    fi


    #startGame
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_play
	ldi r4, 4
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        jsr startGame
        rts
    fi


    #setRules
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_rules
	ldi r4, 5
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readRules
        if
            cmp r1, -1
        is eq
            rts
        fi

        jsr skipSpaces

        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        move r2, r0
        jsr setSurv

        move r5, r0
        jsr setBorn
        rts
    fi


    #pauseGame
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_pause
	ldi r4, 5
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        jsr pauseGame
        rts
    fi


    #invert
    ldi r0, buf
    jsr skipSpaces

	ldi r1, str_inv
	ldi r4, 1
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r3

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r5

        jsr skipSpaces

        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        move r3, r0
        move r5, r1
        jsr invert

        rts
    fi


    #stepOnce
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_step
	ldi r4, 4
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        jsr stepOnce
        rts
    fi


    #speedUp
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_su
	ldi r4, 2
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        jsr speedUp
        rts
    fi


    #speedDown
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_sd
	ldi r4, 2
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        jsr speedDown
        rts
    fi


    #setSpeed
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_ss
	ldi r4, 2
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r2

        jsr skipSpaces

        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        move r2, r0
        jsr setSpeed
        rts
    fi


    #clear
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_clr
	ldi r4, 3
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        jsr clear
        rts
    fi


    #setRectTo1
    ldi r0, buf
    jsr skipSpaces

	ldi r1, str_srect1
	ldi r4, 2
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r3

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r4

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r5

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r6

        jsr skipSpaces

        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        move r3, r0
        move r4, r1
        move r5, r2
        move r6, r3
        jsr setRectTo1

        rts
    fi


    #setRectTo0
    ldi r0, buf
    jsr skipSpaces

	ldi r1, str_srect0
	ldi r4, 2
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r3

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r4

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r5

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r6

        jsr skipSpaces

        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        move r3, r0
        move r4, r1
        move r5, r2
        move r6, r3
        jsr setRectTo0

        rts
    fi


    #saveTemplate
    ldi r0, buf
    jsr skipSpaces

	ldi r1, str_savex
	ldi r4, 5
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        isInBound 0, r1, 4
            move r1, r3
        notInBound
            #print error "too large argument"
            ldi r6, 414
            rts
        fiInBound

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r4

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r5

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r6

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r7

        jsr skipSpaces

        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        move r3, r0
        move r4, r1
        move r5, r2
        move r6, r3
        move r7, r4
        jsr saveTemplate

        rts
    fi


    #loadTemplate
    ldi r0, buf
    jsr skipSpaces

	ldi r1, str_loadx
	ldi r4, 5
	jsr strncmp

    jsr skipSpaces

    if
        cmp r4, 1
    is eq
        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        isInBound 0, r1, 4
            move r1, r3
        notInBound
            #print error "too large argument"
            ldi r6, 414
            rts
        fiInBound

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r4

        jsr skipSpaces

        jsr readUInt
        if
            cmp r1, -1
        is eq
            rts
        fi
        move r1, r5

        jsr skipSpaces

        ldb r0, r1
        if
            cmp r1, 0
        is ne
            #print error "incorrect input"
            ldi r6, 406
            rts
        fi

        move r3, r0
        move r4, r1
        move r5, r2
        jsr insertTemplate

        rts
    fi


    #print error "incorrect command"
    ldi r6, 405
    rts

end
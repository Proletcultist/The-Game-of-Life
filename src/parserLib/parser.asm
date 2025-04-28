asect 0xfee1
buf:

rsect parser

include matrixLib.h
include parserUtils.h
include strLiterals.h
writeToUART: ext

parse>
    ldi r0, buf
    ldb r0, r1
    if
        cmp r1, 0
    is eq
        ldi r0, error_no_com
        jsr writeToUART
        rts
    fi


    #help
    ldi r0, buf
    jsr skipSpaces

    ldi r1, str_help
	ldi r4, 1
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
            ldi r0, error_inc_inp
            jsr writeToUART
            rts
        fi

        ldi r0, str_help_txt
        jsr writeToUART

        ldi r0, str_succ
        jsr writeToUART
        rts
    fi


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
            isInBound 48, r1, 57
                #print error "too many args"
                ldi r0, error_many_args
                jsr writeToUART
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
            fiInBound
            rts
        fi

        move r3, r0
        move r5, r1
        jsr setTo1
        
        ldi r0, str_succ
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
            isInBound 48, r1, 57
                #print error "too many args"
                ldi r0, error_many_args
                jsr writeToUART
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
            fiInBound
            rts
        fi

        move r3, r0
        move r5, r1
        jsr setTo0

        ldi r0, str_succ
        jsr writeToUART
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
            ldi r0, error_inc_inp
            jsr writeToUART
            rts
        fi

        jsr startGame

        ldi r0, str_succ
        jsr writeToUART
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
            ldi r0, error_inc_inp
            jsr writeToUART
            rts
        fi

        move r2, r0
        jsr setSurv

        move r5, r0
        jsr setBorn

        ldi r0, str_succ
        jsr writeToUART
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
            ldi r0, error_inc_inp
            jsr writeToUART
            rts
        fi

        jsr pauseGame

        ldi r0, str_succ
        jsr writeToUART
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
            isInBound 48, r1, 57
                #print error "too many args"
                ldi r0, error_many_args
                jsr writeToUART
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
            fiInBound
            rts
        fi

        move r3, r0
        move r5, r1
        jsr invert

        ldi r0, str_succ
        jsr writeToUART
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
            ldi r0, error_inc_inp
            jsr writeToUART
            rts
        fi

        jsr stepOnce
        
        ldi r0, str_succ
        jsr writeToUART
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
            ldi r0, error_inc_inp
            jsr writeToUART
            rts
        fi

        jsr speedUp

        ldi r0, str_succ
        jsr writeToUART
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
            ldi r0, error_inc_inp
            jsr writeToUART
            rts
        fi

        jsr speedDown

        ldi r0, str_succ
        jsr writeToUART
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
            isInBound 48, r1, 57
                #print error "too many args"
                ldi r0, error_many_args
                jsr writeToUART
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
            fiInBound
            rts
        fi

        move r2, r0
        jsr setSpeed

        ldi r0, str_succ
        jsr writeToUART
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
            ldi r0, error_inc_inp
            jsr writeToUART
            rts
        fi

        jsr clear

        ldi r0, str_succ
        jsr writeToUART
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
            isInBound 48, r1, 57
                #print error "too many args"
                ldi r0, error_many_args
                jsr writeToUART
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
            fiInBound
            rts
        fi

        move r3, r0
        move r4, r1
        move r5, r2
        move r6, r3
        if
            cmp r0, r2
        is hi
            ldi r0, error_x_higher
            jsr writeToUART
            rts
        fi
        if
            cmp r1, r3
        is hi
            ldi r0, error_y_higher
            jsr writeToUART
            rts
        fi
        jsr setRectTo1

        ldi r0, str_succ
        jsr writeToUART
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
            isInBound 48, r1, 57
                #print error "too many args"
                ldi r0, error_many_args
                jsr writeToUART
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
            fiInBound
            rts
        fi

        move r3, r0
        move r4, r1
        move r5, r2
        move r6, r3
        if
            cmp r0, r2
        is hi
            ldi r0, error_x_higher
            jsr writeToUART
            rts
        fi
        if
            cmp r1, r3
        is hi
            ldi r0, error_y_higher
            jsr writeToUART
            rts
        fi
        jsr setRectTo0

        ldi r0, str_succ
        jsr writeToUART
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
            #print error "too large num"
            ldi r0, error_large_num
            jsr writeToUART
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
            isInBound 48, r1, 57
                #print error "too many args"
                ldi r0, error_many_args
                jsr writeToUART
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
            fiInBound
            rts
        fi

        move r3, r0
        move r4, r1
        move r5, r2
        move r6, r3
        move r7, r4
        if
            cmp r1, r3
        is hi
            ldi r0, error_x_higher
            jsr writeToUART
            rts
        fi
        if
            cmp r2, r4
        is hi
            ldi r0, error_y_higher
            jsr writeToUART
            rts
        fi
        jsr saveTemplate

        ldi r0, str_succ
        jsr writeToUART
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
            #print error "too large num"
            ldi r0, error_large_num
            jsr writeToUART
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
            isInBound 48, r1, 57
                #print error "too many args"
                ldi r0, error_many_args
                jsr writeToUART
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
            fiInBound
            rts
        fi

        move r3, r0
        move r4, r1
        move r5, r2
        jsr insertTemplate

        ldi r0, str_succ
        jsr writeToUART
        rts
    fi


    #print error "incorrect command"
    ldi r0, error_inc_com
    jsr writeToUART
    rts

end
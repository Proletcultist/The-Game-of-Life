rsect parserUtils

include strLiterals.h
offsetmasks: ext
writeToUART: ext

#r0 - pointer for buffer
skipSpaces>
    ldb r0, r1
    while
        cmp r1, 32
    stays eq
        inc r0
        ldb r0, r1
    wend

    rts

#r0 - pointer for buffer
#r1 - pointer for str
#r4 - n (number of chars)
strncmp>
    while
        tst r4
    stays nz
        ldb r0, r2
        ldb r1, r3

        if
            cmp r2, r3
        is eq
            inc r0
            inc r1

            dec r4
        else
            ldi r4, 0
            rts
        fi
    wend

    ldb r0, r2
    if
        cmp r2, 32
    is eq
        ldi r4, 1
        rts
    fi

    if
        cmp r2, 0
    is eq
        ldi r4, 1
        rts
    fi

    ldi r4, 0
    rts

#r0 - pointer for buffer
readUInt>
    ldb r0, r1
    
    isInBound 48, r1, 57
        push r1

        inc r0
        ldb r0, r1
        isInBound 48, r1, 57
            move r1, r2
            pop r1

            sub r1, 48
            sub r2, 48
            
            shl r1
            add r1, r2, r2
            shl r1, r1, 2
            add r1, r2, r2

            if
                cmp r2, 31
            is hi
                #print error "large coordinates"
                ldi r0, error_large_coord
                jsr writeToUART
                ldi r1, -1
                rts
            fi

            inc r0
            ldb r0, r1
        notInBound
            pop r2

            sub r2, 48
        fiInBound
        if
            cmp r1, 0
        is eq
            move r2, r1
            rts
        fi
        if
            cmp r1, 32
        is eq
            move r2, r1
            rts
        fi
        #print error "incorrect input"
        ldi r0, error_inc_inp
        jsr writeToUART
        ldi r1, -1
        rts

    notInBound
        if
            cmp r1, 0
        is eq
            #print error "too few args"
            ldi r0, error_few_args
            jsr writeToUART
            ldi r1, -1
        else
            #print error "incorrect input"
            ldi r0, error_inc_inp
            jsr writeToUART
            ldi r1, -1
        fi
        rts
    fiInBound

#r0 - pointer for buffer
readRules>
    clr r2
    clr r5
    ldb r0, r1
    ldi r3, 83
    if
        cmp r1, r3
    is eq
        inc r0
        ldb r0, r1

        clr r4
        while
            cmp r4, 9
        stays lo
            ldi r3, 66
            if
                cmp r1, r3
            is eq
                break
            fi
            isInBound 48, r1, 57
                sub r1, 48

                ldi r3, offsetmasks
                shl r1
                add r3, r1, r3
                ldw r3, r3
                or r3, r2

                inc r4
                inc r0
                ldb r0, r1
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
                ldi r1, -1
                rts
            fiInBound
        wend
        ldi r3, 66
        if
            cmp r1, r3
        is ne
            #print error "incorrect input"
            ldi r0, error_inc_inp
            jsr writeToUART
            ldi r1, -1
            rts
        fi

        if
            cmp r2, 0
        is eq
            #print error "no arguments"
            ldi r0, error_no_args
            jsr writeToUART
            ldi r1, -1
            rts
        fi

        inc r0
        ldb r0, r1

        clr r4
        while
            cmp r4, 9
        stays lo
            if
                cmp r1, 32
            is eq
                break
            fi
            if
                cmp r1, 0
            is eq
                break
            fi
            isInBound 48, r1, 57
                sub r1, 48

                ldi r3, offsetmasks
                shl r1
                add r3, r1, r3
                ldw r3, r3
                or r3, r5

                inc r4
                inc r0
                ldb r0, r1
            notInBound
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
                ldi r1, -1
                rts
            fiInBound
        wend
        if
            cmp r1, 32
        is ne
            if
                cmp r1, 0
            is ne
                #print error "incorrect input"
                ldi r0, error_inc_inp
                jsr writeToUART
                ldi r1, -1
                rts
            fi
        fi

        if
            cmp r5, 0
        is eq
            #print error "no arguments"
            ldi r0, error_no_args
            jsr writeToUART
            ldi r1, -1
            rts
        fi

        rts
    else
        #print error "incorrect input"
        ldi r0, error_inc_inp
        jsr writeToUART
        ldi r1, -1
        rts
    fi
    
end
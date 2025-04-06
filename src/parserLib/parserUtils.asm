asect 0xfeb4
buf:

rsect parserUtils

skipSpaces>
    ldi r1, 32

    ldb r0, r2
    while
        cmp r2, r1
    stays eq
        inc r0
        ldb r0, r2
    wend

    rts

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
    ldi r3, 32
    if
        cmp r2, r3
    is eq
        ldi r4, 1
        rts
    fi

    ldi r3, 0
    if
        cmp r2, r3
    is eq
        ldi r4, 1
        rts
    fi

    ldi r4, 0
    rts

readUInt>
    clr r1
    ldb r0, r3
    
    ldi r2, 57
    if
        cmp r3, r2
    is ls
        ldi r2, 48
        if
            cmp r3, r2
        is hs
            sub r3, r2, r4

            inc r0
            ldb r0, r3

            ldi r2, 57
            if
                cmp r3, r2
            is ls
                ldi r2, 48
                if
                    cmp r3, r2
                is hs
                    sub r3, r2, r5
                    
                    move r5, r1

                    while
                        tst r4
                    stays nz
                        add r1, 10
                        dec r4
                    wend

                    inc r0
                    ldb r0, r3

                    if
                        cmp r1, 31
                    is ls
                        if
                            cmp r3, 32
                        is eq
                            rts
                        fi

                        if
                            cmp r3, 0
                        is eq
                            rts
                        fi

                        # error
                    else
                        # error
                    fi
                else
                    if
                        cmp r3, 32
                    is eq
                        move r4, r1
                        rts
                    fi

                    if
                        cmp r3, 0
                    is eq
                        move r4, r1
                        rts
                    fi

                    # error
                fi
            fi
        fi
    fi


end
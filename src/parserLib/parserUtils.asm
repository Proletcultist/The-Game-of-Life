rsect parserUtils

# $2 <= $1 <= $3
macro isInBound/1
  cmp $1, 48
  blo alt'

  cmp $1, 57
  bhi alt'

  mpush alt'
mend

macro notInBound/0
  mpop where
  mpush new?where
  br new?where
  ?where:  
mend

macro fiInBound/0
  mpop term
  ?term:
mend

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

#r0 - pointer for line
readUInt>
    ldb r0, r1
    
    isInBound r1
        push r1

        inc r0
        ldb r0, r1
        isInBound r1
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
                ldi r6, 400
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
        ldi r6, 401
        rts

    notInBound
        if
            cmp r1, 0
        is eq
            #print error "no args"
            ldi r6, 402
            rts
        fi
        #print error "incorrect input"
        ldi r6, 403
        rts
    fiInBound

#r0 - pointer for line
freeUART>
    ldb r0, r1
    while
        cmp r1, 10
    stays ne
        ldb r0, r1
    wend
    rts
end
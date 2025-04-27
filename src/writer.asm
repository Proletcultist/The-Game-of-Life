asect 0xff7a
uart:

rsect writer

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
    ldi r2, 13
    stb r1, r2
    ldi r2, 10
    stb r1, r2

end
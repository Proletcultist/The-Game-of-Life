# Start function, prepare runtime

main: ext

rsect start

start>
	ldi r0, 0xfee1
	stsp r0

	jsr main
	
	halt

end

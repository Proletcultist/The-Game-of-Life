# Main program section
rsect main

sample_1_int: ext

main>
	ldi r0, 0xff00
	stsp r0

	ldi r6, sample_1_int
	
	ei

	ldi r0, 1
	ldi r0, 5

	w:
	wait
	br w

end

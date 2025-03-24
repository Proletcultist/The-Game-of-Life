# Main program section
rsect main

sample_1_int: ext

main>
	ldi r0, 0xff00
	stsp r0
	
	ei

	w:
	wait
	br w

end

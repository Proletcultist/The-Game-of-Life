# Exception handlers section
rsect exc_handlers

default_handler>
	ldi r3, 404
    halt

sample_1_int>
	ldi r0, 588
	rti

sample_2_int>
	ldi r6, 7
	rti

end

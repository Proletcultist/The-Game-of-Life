# Exception handlers section
rsect exc_handlers

default_handler>
    halt

sample_1_int>
	ldi r0, 69
	rti

sample_2_int>
	ldi r0, 69
	halt

end

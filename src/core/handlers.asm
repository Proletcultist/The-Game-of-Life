rsect handlers

parse: ext
readFromUART: ext
writeToUART: ext

include strLiterals.h

default_handler>
	ldi r3, 404
    halt

helloPrint>
	ldi r0, str_hello
	jsr writeToUART
	rti

getLine>
	jsr readFromUART

	if 
		cmp r0, -1
	is eq
		rti
	fi

	jsr parse

	ldi r0, str_input
	jsr writeToUART

	rti

end

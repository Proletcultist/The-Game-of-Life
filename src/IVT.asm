asect 0
start: ext
default_handler: ext    # as external
helloPrint: ext
getLine: ext

dc start, 0              # Startup/Reset vector
dc default_handler, 0   # Unaligned SP
dc default_handler, 0   # Unaligned PC
dc default_handler, 0   # Invalid instruction
dc default_handler, 0   # Double fault

align 0x40		# Reserved vectors

dc helloPrint, 0
dc getLine, 0

align 0x80              # Reserve space for the rest 
                        # of IVT

end

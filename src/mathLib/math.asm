rsect math

# r0 * r1 -> r0
uMult>
	clr r2

	while
		tst r0
	stays nz
		if
			shr r0
		is cs
			add r1, r2
		fi	

		shl r1
	wend	

	move r2, r0

	rts

end

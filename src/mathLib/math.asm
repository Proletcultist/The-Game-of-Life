rsect math

# r0 * r1 -> r0
uMult>
	clr r2

	while
		tst r1
	stays nz
		if
			shr r1
		is nz
			add r0, r2
		else
		fi	

		shl r0
	wend	

	move r2, r0

end

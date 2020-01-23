patch ops
multiplyVar: var by: num
	bcGenerator
		multiplyVar: (targetMorph patchVarId varNoFor: var choice)
		by: [ num argString: parser ]
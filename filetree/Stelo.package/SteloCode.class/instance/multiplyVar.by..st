patch ops
multiplyVar: var by: num
	generator
		multiplyVar: (script patchVarId varNoFor: var choice)
		by: [ num argString: parser ]
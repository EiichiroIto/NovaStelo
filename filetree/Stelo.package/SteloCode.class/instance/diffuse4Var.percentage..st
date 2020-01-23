patch ops
diffuse4Var: var percentage: num
	bcGenerator
		diffuse4Var: (targetMorph patchVarId varNoFor: var choice)
		percentage: [ num argString: parser ].
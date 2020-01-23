patch ops
diffuseVar: var percentage: num
	bcGenerator
		diffuseVar: (targetMorph patchVarId varNoFor: var choice)
		percentage: [ num argString: parser ].
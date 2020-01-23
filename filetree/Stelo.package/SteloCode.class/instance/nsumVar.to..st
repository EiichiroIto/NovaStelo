patch ops
nsumVar: var1 to: var2
	bcGenerator
		nsumVar: (targetMorph patchVarId varNoFor: var1 choice)
		to: (targetMorph patchVarId varNoFor: var2 choice).
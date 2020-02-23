patch ops
nsumVar: var1 to: var2
	generator
		nsumVar: (script patchVarId varNoFor: var1 choice)
		to: (script patchVarId varNoFor: var2 choice).
patch ops
nsum4Var: var1 to: var2
	bcGenerator
		nsum4Var: (targetMorph patchVarId varNoFor: var1 choice)
		to: (targetMorph patchVarId varNoFor: var2 choice).
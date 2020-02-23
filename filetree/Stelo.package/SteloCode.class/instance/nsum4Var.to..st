patch ops
nsum4Var: var1 to: var2
	generator
		nsum4Var: (script patchVarId varNoFor: var1 choice)
		to: (script patchVarId varNoFor: var2 choice).
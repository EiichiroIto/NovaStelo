evaluation
evaluateWithArgs: args
	"Overridden to read my variable value."

	^ receiver getVar: commandSpec

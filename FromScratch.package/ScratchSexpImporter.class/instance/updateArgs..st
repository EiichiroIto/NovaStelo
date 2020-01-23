private
updateArgs: anArray
	anArray at: 1 put: (anArray at: 1) asSymbol.
	2 to: anArray size do: [ :each | 
		| arg |
		arg := anArray at: each.
		arg := self evaluateArg: arg.
		anArray at: each put: arg ]
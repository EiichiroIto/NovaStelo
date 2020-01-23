accessing
setVar: anInteger toAll: anObject
	(self varAt: anInteger asInteger)
		in:
			[ :variable | 1 to: variable size do: [ :each | variable at: each put: anObject ] ]
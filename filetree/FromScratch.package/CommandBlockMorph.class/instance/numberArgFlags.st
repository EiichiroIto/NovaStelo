accessing
numberArgFlags
	"Answer an array of booleans indicating which of my arguments must be numbers. Compute on first use and cache the result."

	| argSpecs |
	numberArgFlags ifNotNil: [ ^ numberArgFlags ].
	argSpecs := (self class parseCommandSpec: commandSpec)
		select: [ :s | self class isArgSpec: s ].
	argSpecs := self organizeArgs: argSpecs.
	numberArgFlags := argSpecs
		collect:
			[ :spec | (self script uncoloredArgMorphFor: spec) isNumberExpression ].
	^ numberArgFlags
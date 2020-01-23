accessing
numberArgFlags
	"Answer an array of booleans indicating which of my arguments must be numbers. Compute on first use and cache the result."

	| argSpecs argM |
	numberArgFlags ifNotNil: [ ^ numberArgFlags ].
	argSpecs := (CommandBlockMorph parseCommandSpec: commandSpec)
		select: [ :s | CommandBlockMorph isArgSpec: s ].
	argSpecs := self organizeArgs: argSpecs.
	numberArgFlags := argSpecs
		collect: [ :spec | 
			argM := self script uncoloredArgMorphFor: spec.
			(argM isKindOf: ExpressionArgMorph)
				ifTrue: [ argM isNumberExpression ]
				ifFalse: [ false ] ].
	^ numberArgFlags.
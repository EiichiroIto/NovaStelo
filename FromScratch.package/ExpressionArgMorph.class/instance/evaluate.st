evaluation
evaluate
	"Answer the result of evaluating my expression in the context of the given ScratchProcess."

	| expr |
	expr := labelMorph savedContents.
	isNumber
		ifTrue: [^ expr asNumberNoError]
		ifFalse: [^ expr].  "string"

evaluation
evaluate
	"Answer the result of evaluating my expression in the context of the given ScratchProcess."

	specialValue ifNotNil: [^ specialValue].
	^ super evaluate

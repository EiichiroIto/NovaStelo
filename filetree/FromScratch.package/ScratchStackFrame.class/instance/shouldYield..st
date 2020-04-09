accessing
shouldYield: aBoolean
	"Makes this into a special stack frame that tells the evaluator to yield control to another process. When this flag is set, the rest of the stack frame is ignored."

	aBoolean
		ifTrue: [ expression := #shouldYield ]
		ifFalse: [ self error: 'Should not call shouldYield: with false.' ]
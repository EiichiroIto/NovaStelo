accessing
expression: anObject
	"Sets the expression to evaluate. This can be a single block or a collection of blocks. It should only be called before running the process."

	stackFrame ifNotNil: [ self error: 'Cannot modify expression' ].
	stackFrame := ScratchStackFrame new expression: anObject
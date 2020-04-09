private
evaluateCommandFor: anApplication
	"Evaluates the current block. If the argument is non-nil, redraw the stage."

	| expression |
	expression := stackFrame expression.
	self class blockHighlightMSecs > 1
		ifTrue: [ expression litUp: true ].
	expression isSpecialForm
		ifTrue: [ ^ self evaluateSpecialForm ].

	"evaluate arguments, if necessary"
	stackFrame arguments size < expression argumentCount
		ifTrue: [ ^ self evaluateNextArgument ].
	expression isTimed
		ifTrue: [ ^ self applyTimedCommand ].
	self applyPrimitive
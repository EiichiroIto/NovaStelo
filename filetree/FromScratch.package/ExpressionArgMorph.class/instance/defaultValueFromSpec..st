accessing
defaultValueFromSpec: anObject
	"Like defaultValue:, but '-' in a block spec creates an empty number expression."

	self defaultValue: anObject.
	'-' = anObject ifTrue: [self numExpression: ' '].  "empty, evaluates to zero"

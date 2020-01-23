other
acceptsTypeOf: aBlockMorph
	"Answer true if I can accept a dropped reporter of the given type. Answer false by default."

	aBlockMorph isReporter ifFalse: [^ false].
	^ aBlockMorph isBooleanReporter = self isBooleanReporter

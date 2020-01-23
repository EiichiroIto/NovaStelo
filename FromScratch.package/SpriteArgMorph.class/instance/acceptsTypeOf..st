other
acceptsTypeOf: aBlockMorph
	"Answer true if I can accept a dropped reporter of the given type."

	aBlockMorph isReporter ifFalse: [^ false].
	^ aBlockMorph isBooleanReporter not

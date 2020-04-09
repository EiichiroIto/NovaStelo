accessing
litUp: aBoolean
	"If the argument true, light up this block. Otherwise, revert to it's old color."

	"Note: We use super color: so we don't overwrite oldColor. We also force a world update to ensure that the highlighting is seen by the user."

	aBoolean
		ifTrue: [ super color: (Color h: 60 s: 0.9 v: 0.89) ]
		ifFalse: [ oldColor ifNotNil: [ super color: oldColor ] ]
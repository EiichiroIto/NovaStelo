accessing variable
var: anInteger1 at: anInteger2
	anInteger1 = varId class xVarNo
		ifTrue: [ ^ self xAt: anInteger2 ].
	anInteger1 = varId class yVarNo
		ifTrue: [ ^ self yAt: anInteger2 ].
	^ super var: anInteger1 at: anInteger2
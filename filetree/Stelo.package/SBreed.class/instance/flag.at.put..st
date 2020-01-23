accessing variable
flag: anInteger at: id put: aBoolean
	| vars v b |
	vars := variables varAt: varId class flagVarNo.
	b := 1 << anInteger.
	v := vars at: id.
	v := aBoolean
		ifTrue: [ v bitOr: b ]
		ifFalse: [ v bitClear: b ].
	vars at: id put: v
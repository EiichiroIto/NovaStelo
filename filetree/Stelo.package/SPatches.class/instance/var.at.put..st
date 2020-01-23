accessing variable
var: anInteger at: id put: aNumber
	| data |
	data := aNumber.
	anInteger = varId class colorVarNo
		ifTrue: [ data := SColorList default normalize: data ].
	super var: anInteger at: id put: data.
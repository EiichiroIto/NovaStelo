accessing variable
var: anInteger at: id put: aNumber
	| data |
	data := aNumber.
	anInteger = varId class colorVarNo
		ifTrue: [ data := SColorList default normalize: data.
			defaultColor := data ].
	anInteger = varId class headingVarNo
		ifTrue: [ data := aNumber \\ 360 ].
	super var: anInteger at: id put: data
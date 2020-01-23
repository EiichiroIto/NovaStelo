patch ops
scalePatch: var color: color from: from to: to
	bcGenerator
		scaleValue: (targetMorph patchVarId varNoFor: var choice)
		color: [ color argString: parser ]
		from: [ from argString: parser ]
		to: [ to argString: parser ]
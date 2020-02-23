patch ops
scalePatch: var color: color from: from to: to
	generator
		scaleValue: (script patchVarId varNoFor: var choice)
		color: [ color argString: parser ]
		from: [ from argString: parser ]
		to: [ to argString: parser ]
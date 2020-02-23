arithmetic ops
multiply: x and: y
	^ generator
		multiply: [ x argString: parser ]
		and: [ y argString: parser ]
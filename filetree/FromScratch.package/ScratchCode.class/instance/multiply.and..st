arithmetic ops
multiply: x and: y
	^ bcGenerator
		multiply: [ x argString: parser ]
		and: [ y argString: parser ]
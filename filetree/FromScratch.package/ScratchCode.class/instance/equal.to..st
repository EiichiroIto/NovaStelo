arithmetic ops
equal: x to: y
	^ generator
		equal: [ x argString: parser ]
		to: [ y argString: parser ]
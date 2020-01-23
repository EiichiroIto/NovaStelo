arithmetic ops
equal: x to: y
	^ bcGenerator
		equal: [ x argString: parser ]
		to: [ y argString: parser ]
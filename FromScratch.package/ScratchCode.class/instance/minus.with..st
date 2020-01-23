arithmetic ops
minus: x with: y
	^ bcGenerator
		minus: [ x argString: parser ]
		with: [ y argString: parser ]
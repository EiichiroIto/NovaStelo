arithmetic ops
or: x with: y
	^ bcGenerator
		or: [ x argString: parser ]
		with: [ y argString: parser ]
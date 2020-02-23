arithmetic ops
or: x with: y
	^ generator
		or: [ x argString: parser ]
		with: [ y argString: parser ]
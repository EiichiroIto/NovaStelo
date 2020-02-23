arithmetic ops
minus: x with: y
	^ generator
		minus: [ x argString: parser ]
		with: [ y argString: parser ]
arithmetic ops
bitAnd: x with: y
	^ generator
		bitAnd: [ x argString: parser ]
		with: [ y argString: parser ]
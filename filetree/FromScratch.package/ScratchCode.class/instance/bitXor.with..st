arithmetic ops
bitXor: x with: y
	^ generator
		bitXor: [ x argString: parser ]
		with: [ y argString: parser ]
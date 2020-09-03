arithmetic ops
bitOr: x with: y
	^ generator
		bitOr: [ x argString: parser ]
		with: [ y argString: parser ]
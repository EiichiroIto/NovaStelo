arithmetic ops
bitShift: x right: y
	^ generator
		bitShift: [ x argString: parser ]
		right: [ y argString: parser ]
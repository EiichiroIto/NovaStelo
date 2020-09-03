arithmetic ops
bitShift: x left: y
	^ generator
		bitShift: [ x argString: parser ]
		left: [ y argString: parser ]
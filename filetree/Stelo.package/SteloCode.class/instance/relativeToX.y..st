sensing ops
relativeToX: x y: y
	^ generator
		relativeToX: [ x argString: parser ]
		y: [ y argString: parser ]
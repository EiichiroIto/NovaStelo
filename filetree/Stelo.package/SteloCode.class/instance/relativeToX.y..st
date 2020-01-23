sensing ops
relativeToX: x y: y
	^ bcGenerator
		relativeToX: [ x argString: parser ]
		y: [ y argString: parser ]
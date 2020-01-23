sensing ops
patchAtX: x y: y
	^ bcGenerator
		patchAtX: [ x argString: parser ]
		y: [ y argString: parser ]
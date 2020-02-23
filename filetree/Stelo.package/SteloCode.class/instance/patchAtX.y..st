sensing ops
patchAtX: x y: y
	^ generator
		patchAtX: [ x argString: parser ]
		y: [ y argString: parser ]
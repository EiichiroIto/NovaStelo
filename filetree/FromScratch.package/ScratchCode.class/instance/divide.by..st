arithmetic ops
divide: x by: y
	^ generator
		divide: [ x argString: parser ]
		by: [ y argString: parser ]
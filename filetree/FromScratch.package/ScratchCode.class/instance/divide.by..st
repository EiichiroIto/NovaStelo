arithmetic ops
divide: x by: y
	^ bcGenerator
		divide: [ x argString: parser ]
		by: [ y argString: parser ]
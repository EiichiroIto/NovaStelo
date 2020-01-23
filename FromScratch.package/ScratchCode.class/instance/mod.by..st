arithmetic ops
mod: x by: y
	^ bcGenerator
		mod: [ x argString: parser ]
		by: [ y argString: parser ]
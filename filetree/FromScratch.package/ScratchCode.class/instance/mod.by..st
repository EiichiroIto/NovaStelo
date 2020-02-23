arithmetic ops
mod: x by: y
	^ generator
		mod: [ x argString: parser ]
		by: [ y argString: parser ]
arithmetic ops
and: x with: y
	^ bcGenerator
		and: [ x argString: parser ]
		with: [ y argString: parser ]
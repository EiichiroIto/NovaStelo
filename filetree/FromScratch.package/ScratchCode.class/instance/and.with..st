arithmetic ops
and: x with: y
	^ generator
		and: [ x argString: parser ]
		with: [ y argString: parser ]
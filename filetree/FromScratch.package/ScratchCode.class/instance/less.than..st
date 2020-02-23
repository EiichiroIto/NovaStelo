arithmetic ops
less: x than: y
	^ generator
		less: [ x argString: parser ]
		than: [ y argString: parser ]
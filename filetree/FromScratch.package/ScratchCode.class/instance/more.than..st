arithmetic ops
more: x than: y
	^ generator
		less: [ y argString: parser ]
		than: [ x argString: parser ]
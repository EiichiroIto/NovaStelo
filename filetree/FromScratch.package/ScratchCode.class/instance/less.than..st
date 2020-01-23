arithmetic ops
less: x than: y
	^ bcGenerator
		less: [ x argString: parser ]
		than: [ y argString: parser ]
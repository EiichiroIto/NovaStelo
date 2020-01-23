arithmetic ops
more: x than: y
	^ bcGenerator
		less: [ y argString: parser ]
		than: [ x argString: parser ]
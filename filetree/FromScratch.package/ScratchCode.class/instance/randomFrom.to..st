arithmetic ops
randomFrom: a to: b
	^ bcGenerator
		randomFrom: [ a argString: parser ]
		to: [ b argString: parser ]
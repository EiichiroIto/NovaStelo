arithmetic ops
randomFrom: a to: b
	^ generator
		randomFrom: [ a argString: parser ]
		to: [ b argString: parser ]
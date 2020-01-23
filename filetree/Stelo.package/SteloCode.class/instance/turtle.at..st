sensing ops
turtle: bno at: pno
	^ bcGenerator
		turtle: [ bno argString: parser ]
		at: [ pno argString: parser ]
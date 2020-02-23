sensing ops
turtle: bno at: pno
	^ generator
		turtle: [ bno argString: parser ]
		at: [ pno argString: parser ]
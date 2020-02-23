sensing ops
relativeToR: r theta: theta
	^ generator
		relativeToR: [ r argString: parser ]
		theta: [ theta argString: parser ]
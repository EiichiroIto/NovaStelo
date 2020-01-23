sensing ops
relativeToR: r theta: theta
	^ bcGenerator
		relativeToR: [ r argString: parser ]
		theta: [ theta argString: parser ]
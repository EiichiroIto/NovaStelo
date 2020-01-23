patch ops
setPatchColorAt: pos to: color
	bcGenerator
		setPatchColorAt: [ pos argString: parser ]
		to: [ color argString: parser ]
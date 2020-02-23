patch ops
setPatchColorAt: pos to: color
	generator
		setPatchColorAt: [ pos argString: parser ]
		to: [ color argString: parser ]
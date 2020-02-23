arithmetic ops
is: x between: from and: to
	^ generator
		is: [ x argString: parser ]
		between: [ from argString: parser ]
		and: [ to argString: parser ]
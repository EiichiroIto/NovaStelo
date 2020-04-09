patch ops
changeObserverVar: var by: num
	generator
		changeObserverVar: (script observerVarId varNoFor: var choice)
		by: [ num argString: parser ]
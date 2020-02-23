patch ops
setPatchVar: var at: pno to: num
	generator
		setPatchVar: (script patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
		to: [ num argString: parser ].
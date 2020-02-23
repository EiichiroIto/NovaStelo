patch ops
changePatchVar: var at: pno by: num
	generator
		changePatchVar: (script patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
		by: [ num argString: parser ].
patch ops
changePatchVar: var at: pno by: num
	bcGenerator
		changePatchVar: (targetMorph patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
		by: [ num argString: parser ].
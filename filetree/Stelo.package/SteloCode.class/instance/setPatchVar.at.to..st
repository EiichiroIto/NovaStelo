patch ops
setPatchVar: var at: pno to: num
	bcGenerator
		setPatchVar: (targetMorph patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
		to: [ num argString: parser ].
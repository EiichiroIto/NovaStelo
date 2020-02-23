patch ops
getPatchVar: var at: pno
	^ generator
		getPatchVar: (script patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
patch ops
getPatchVar: var at: pno
	^ bcGenerator
		getPatchVar: (targetMorph patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
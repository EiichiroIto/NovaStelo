variable ops
getVar: var
	| v |
	v := var variable.
	^ bcGenerator getVar: (targetMorph varId varNoFor: v)
variable ops
getVar: var
	| v |
	v := var variable.
	^ generator getVar: (script varId varNoFor: v)
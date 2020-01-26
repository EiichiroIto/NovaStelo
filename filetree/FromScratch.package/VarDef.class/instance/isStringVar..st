testing
isStringVar: vno
	| v |
	v := varNames at: vno.
	^ (varClasses at: v ifAbsent: [ ^ false ]) = #StringArray
accessing
addVariable: aString
	| id |
	id := varId addVariable: aString.
	variables updateVarDef: varId.
	^ id
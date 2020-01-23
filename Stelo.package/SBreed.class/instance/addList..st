accessing
addList: aString
	| id |
	id := varId addList: aString.
	variables updateVarDef: varId.
	^ id
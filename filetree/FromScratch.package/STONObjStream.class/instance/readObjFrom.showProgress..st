entry points
readObjFrom: aStream showProgress: aBoolean
	| str |
	str := aStream upToEnd asString.
	^ STON fromString: str
entry points
storeObj: anObject on: aStream
	| str |
	str := STON toString: anObject.
	aStream nextPutAll: str asByteArray
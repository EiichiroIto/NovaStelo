accessing
stringAt: anInteger
	| id |
	id := self at: anInteger.
	^ self stringOf: id
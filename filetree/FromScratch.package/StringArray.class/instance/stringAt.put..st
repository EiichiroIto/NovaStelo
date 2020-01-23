accessing
stringAt: anInteger put: aString
	| id |
	id := self idOf: aString.
	^ self at: anInteger put: id
copying
forceTo: anInteger paddingWith: aString
	| id |
	id := self idOf: aString.
	array := array forceTo: anInteger paddingWith: id.
	^ self
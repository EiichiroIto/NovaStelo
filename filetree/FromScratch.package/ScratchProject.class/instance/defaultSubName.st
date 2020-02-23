accessing
defaultSubName
	| list |
	list := self allSubNames.
	^ list isEmpty
		ifTrue: [ '' ]
		ifFalse: [ list first ]
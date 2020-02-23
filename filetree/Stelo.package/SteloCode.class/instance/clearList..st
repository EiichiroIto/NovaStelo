list ops
clearList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ generator clearList: (script varId varNoFor: v)
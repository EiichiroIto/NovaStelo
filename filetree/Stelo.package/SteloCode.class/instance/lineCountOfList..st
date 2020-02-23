list ops
lineCountOfList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ generator lineCountOfList: (script varId varNoFor: v)
list ops
lineCountOfList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ bcGenerator lineCountOfList: (targetMorph varId varNoFor: v)
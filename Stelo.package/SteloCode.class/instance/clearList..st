list ops
clearList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ bcGenerator clearList: (targetMorph varId varNoFor: v)
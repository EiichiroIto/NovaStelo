list ops
append: anObject toList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		append: [ anObject argString: parser ]
		toList: (targetMorph varId varNoFor: v)
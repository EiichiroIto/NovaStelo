list ops
append: anObject toList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		append: [ anObject argString: parser ]
		toList: (script varId varNoFor: v)
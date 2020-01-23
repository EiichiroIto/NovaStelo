list ops
list: aList contains: anInteger
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ bcGenerator
		list: (targetMorph varId varNoFor: v)
		contains: [ anInteger argString: parser ]
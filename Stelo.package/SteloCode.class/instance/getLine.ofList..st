list ops
getLine: anInteger ofList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ bcGenerator
		getLine: [ anInteger argString: parser ]
		ofList: (targetMorph varId varNoFor: v)
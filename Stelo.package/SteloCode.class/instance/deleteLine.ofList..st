list ops
deleteLine: anInteger ofList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		deleteLine: [ anInteger argString: parser ]
		ofList: (targetMorph varId varNoFor: v)
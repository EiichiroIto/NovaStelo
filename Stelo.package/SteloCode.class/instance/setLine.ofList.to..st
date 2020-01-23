list ops
setLine: anInteger ofList: aList to: anObject
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		setLine: [ anInteger argString: parser ]
		ofList: (targetMorph varId varNoFor: v)
		to: [ anObject argString: parser ]
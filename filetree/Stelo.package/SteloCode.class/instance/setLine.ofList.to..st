list ops
setLine: anInteger ofList: aList to: anObject
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		setLine: [ anInteger argString: parser ]
		ofList: (script varId varNoFor: v)
		to: [ anObject argString: parser ]
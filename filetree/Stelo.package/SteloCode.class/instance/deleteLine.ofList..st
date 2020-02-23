list ops
deleteLine: anInteger ofList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		deleteLine: [ anInteger argString: parser ]
		ofList: (script varId varNoFor: v)
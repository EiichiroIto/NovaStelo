list ops
getLine: anInteger ofList: aList
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ generator
		getLine: [ anInteger argString: parser ]
		ofList: (script varId varNoFor: v)
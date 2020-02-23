list ops
list: aList contains: anInteger
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ generator
		list: (script varId varNoFor: v)
		contains: [ anInteger argString: parser ]
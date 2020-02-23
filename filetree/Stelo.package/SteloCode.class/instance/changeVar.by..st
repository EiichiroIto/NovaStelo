variable ops
changeVar: var by: num
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		changeVar: [ script varId varNoFor: v ]
		by: [ num argString: parser ].
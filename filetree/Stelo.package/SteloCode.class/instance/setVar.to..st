variable ops
setVar: var to: num
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		setVar: (script varId varNoFor: v)
		to: [ num argString: parser ].
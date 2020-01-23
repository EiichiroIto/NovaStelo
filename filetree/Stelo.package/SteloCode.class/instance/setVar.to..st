variable ops
setVar: var to: num
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		setVar: (targetMorph varId varNoFor: v)
		to: [ num argString: parser ].
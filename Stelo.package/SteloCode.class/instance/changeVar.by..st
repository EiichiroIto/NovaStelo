variable ops
changeVar: var by: num
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		changeVar: [ targetMorph varId varNoFor: v ]
		by: [ num argString: parser ].
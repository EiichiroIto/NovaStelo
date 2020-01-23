color ops
scaleValue: var color: color from: from to: to
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ ^ self ].
	bcGenerator
		scaleValue: (targetMorph varId varNoFor: v)
		color: [ color argString: parser ]
		from: [ from argString: parser ]
		to: [ to argString: parser ]
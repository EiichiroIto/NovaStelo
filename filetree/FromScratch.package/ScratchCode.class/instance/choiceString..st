private
choiceString: aMorph
	| v |
	v := aMorph choice.
	(v isString and: [ v isEmpty ])
		ifTrue: [ self error: 'Choice is empty!' ].
	^ v
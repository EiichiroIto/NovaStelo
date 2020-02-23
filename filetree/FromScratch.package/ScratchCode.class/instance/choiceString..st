private
choiceString: aMorph
	| v |
	v := aMorph choice.
	v isEmpty ifTrue: [ self error: 'choice is empty' ].
	^ v
menu actions
setMaxValue: aPlotter
	| ret |
	ret := UIManager default
		request: 'maximum plot value?' localized
		initialAnswer: (aPlotter max ifNil: [ '' ]) asString.
	ret ifNil: [ ^ self ].
	ret := ret isEmpty
		ifTrue: [ nil ]
		ifFalse: [ ret asNumberNoError ].
	aPlotter max: ret
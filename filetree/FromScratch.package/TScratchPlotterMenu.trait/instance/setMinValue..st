menu actions
setMinValue: aPlotter
	| ret |
	ret := UIManager default
		request: 'minimum plot value?' localized
		initialAnswer: (aPlotter min ifNil: [ '' ]) asString.
	ret ifNil: [ ^ self ].
	ret := ret isEmpty
		ifTrue: [ nil ]
		ifFalse: [ ret asNumberNoError ].
	aPlotter min: ret
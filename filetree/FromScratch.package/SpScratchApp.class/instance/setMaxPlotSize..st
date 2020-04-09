menu actions
setMaxPlotSize: aPlotter
	| ret |
	ret := UIManager default
		request: 'number of max plots?'
		initialAnswer: (aPlotter maxSize ifNil: [ '' ]) asString.
	ret ifNil: [ ^ self ].
	ret := ret isEmpty
		ifTrue: [ nil ]
		ifFalse: [ ret asNumberNoError ].
	aPlotter maxSize: ret
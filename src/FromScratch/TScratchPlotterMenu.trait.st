Trait {
	#name : #TScratchPlotterMenu,
	#category : #'FromScratch-Spec2'
}

{ #category : #'menu actions' }
TScratchPlotterMenu >> savePlotImage: aPlotter [
	| fName saveForm pngExt |
	pngExt := 'png'.
	saveForm := self formFrom: aPlotter extent: 400 @ 400.
	saveForm ifNil: [ ^ self ].
	fName := self application
		chooseNewFileDefault: ''
		extension: pngExt
		title: 'Save Plots Snapshot' localized
		type: #scriptsSnapshot.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: pngExt.
	saveForm writePNGFileNamed: fName pathString
]

{ #category : #'menu actions' }
TScratchPlotterMenu >> setMaxPlotSize: aPlotter [
	| ret |
	ret := UIManager default
		request: 'number of max plots?' localized
		initialAnswer: (aPlotter maxSize ifNil: [ '' ]) asString.
	ret ifNil: [ ^ self ].
	ret := ret isEmpty
		ifTrue: [ nil ]
		ifFalse: [ ret asNumberNoError ].
	aPlotter maxSize: ret
]

{ #category : #'menu actions' }
TScratchPlotterMenu >> setMaxValue: aPlotter [
	| ret |
	ret := UIManager default
		request: 'maximum plot value?' localized
		initialAnswer: (aPlotter max ifNil: [ '' ]) asString.
	ret ifNil: [ ^ self ].
	ret := ret isEmpty
		ifTrue: [ nil ]
		ifFalse: [ ret asNumberNoError ].
	aPlotter max: ret
]

{ #category : #'menu actions' }
TScratchPlotterMenu >> setMinValue: aPlotter [
	| ret |
	ret := UIManager default
		request: 'minimum plot value?' localized
		initialAnswer: (aPlotter min ifNil: [ '' ]) asString.
	ret ifNil: [ ^ self ].
	ret := ret isEmpty
		ifTrue: [ nil ]
		ifFalse: [ ret asNumberNoError ].
	aPlotter min: ret
]

{ #category : #'menu actions' }
TScratchPlotterMenu >> setPlotPeriod: aPlotter [
	| ret |
	ret := UIManager default
		request: 'update plot period? (in milliseconds)' localized
		initialAnswer: (aPlotter updatePeriod ifNil: [ '' ]) asString.
	(ret isNil or: [ ret isEmpty ])
		ifTrue: [ ^ self ].
	ret := ret asNumberNoError.
	aPlotter updatePeriod: ret
]

{ #category : #'menu actions' }
TScratchPlotterMenu >> showMenuForPlotter: aPlotter event: anEvent [
	| m checked unchecked |
	checked := Smalltalk ui iconNamed: #smallOk.
	unchecked := Smalltalk ui iconNamed: #blank.
	m := self newMenu.
	m
		title: 'Plotter menu' localized;
		addItem: [ :item | 
			item
				name: 'Plot data' localized;
				action: [ aPlotter acceptPlots: aPlotter acceptPlots not ];
				icon: [ aPlotter acceptPlots
						ifTrue: [ checked ]
						ifFalse: [ unchecked ] ];
				autoRefresh: true ].
	m
		addItem: [ :item | 
			item
				name: 'Clear plots' localized;
				action: [ aPlotter clearPlots ] ].
	m
		addItem: [ :item | 
			item
				name: 'Set min value' localized;
				action: [ self setMinValue: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Set max value' localized;
				action: [ self setMaxValue: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Set max plots' localized;
				action: [ self setMaxPlotSize: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Set update period' localized;
				action: [ self setPlotPeriod: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Save plot data' localized;
				action: [ self savePlotImage: aPlotter ] ].
	m openWithSpecAt: anEvent cursorPoint
]

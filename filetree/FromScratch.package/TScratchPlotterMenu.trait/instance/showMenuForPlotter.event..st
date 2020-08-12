menu actions
showMenuForPlotter: aPlotter event: anEvent
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
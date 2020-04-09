menu actions
showMenuForPlotter: aPlotter event: anEvent
	| m checked unchecked |
	checked := Smalltalk ui iconNamed: #smallOk.
	unchecked := Smalltalk ui iconNamed: #blank.
	m := self newMenu.
	m
		title: 'Plotter menu';
		addItem: [ :item | 
			item
				name: 'Plot data';
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
				name: 'Set max plots' localized;
				action: [ application setMaxPlotSize: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Set update period' localized;
				action: [ application setPlotPeriod: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Save plot data' localized;
				action: [ application savePlotImage: aPlotter ] ].
	m openWithSpecAt: anEvent cursorPoint
private
exportMenu
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Export Scripts in S-EXP' localized;
				action: [ application exportSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Export Plots as CSV' localized;
				action: [ application exportPlots ] ];
		yourself
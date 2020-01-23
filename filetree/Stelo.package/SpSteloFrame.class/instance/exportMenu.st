private
exportMenu
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Export Scripts in S-EXP';
				action: [ application exportSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Export Plots as CSV';
				action: [ application exportPlots ] ];
		yourself
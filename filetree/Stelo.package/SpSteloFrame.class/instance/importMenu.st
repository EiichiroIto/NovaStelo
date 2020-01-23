private
importMenu
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Import Scripts';
				action: [ application importSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Import Plots';
				action: [ application importPlots ] ];
		yourself
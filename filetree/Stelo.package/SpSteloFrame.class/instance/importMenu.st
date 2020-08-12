private
importMenu
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Import Scripts' localized;
				action: [ application importSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Import Plots' localized;
				action: [ application importPlots ] ];
		yourself
private
fileMenu
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'New' localized;
						action: [ application newProject.
							self plotter clearPlots ] ];
				addItem: [ :item | 
					item
						name: 'Open' localized;
						action: [ application openProject.
							self plotter clearPlots ] ];
				addItem: [ :item | 
					item
						name: 'Project Notes' localized;
						action: [ application editNotes ] ];
				addItem: [ :item | 
					item
						name: 'Save' localized;
						action: [ application saveProjectNoDialog ] ];
				addItem: [ :item | 
					item
						name: 'Save As' localized;
						action: [ application saveProject ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Import ...' localized;
						subMenu: self importMenu ];
				addItem: [ :item | 
					item
						name: 'Export ...' localized;
						subMenu: self exportMenu ] ];
		addItem: [ :item | 
			item
				name: 'Close' localized;
				action: [ application close ];
				enabled: [ application class dontClose not ] ];
		addItem: [ :item | 
			item
				name: 'Quit' localized;
				action: [ application quit ] ];
		yourself
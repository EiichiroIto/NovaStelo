private
fileMenu
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'New';
						action: [ application newProject.
							self plotter clearPlots ] ];
				addItem: [ :item | 
					item
						name: 'Open';
						action: [ application openProject.
							self plotter clearPlots ] ];
				addItem: [ :item | 
					item
						name: 'Project Notes';
						action: [ application editNotes ] ];
				addItem: [ :item | 
					item
						name: 'Save';
						action: [ application saveProjectNoDialog ] ];
				addItem: [ :item | 
					item
						name: 'Save As';
						action: [ application saveProject ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Import';
						subMenu: self importMenu ];
				addItem: [ :item | 
					item
						name: 'Export';
						subMenu: self exportMenu ] ];
		addItem: [ :item | 
			item
				name: 'Close';
				action: [ application close ];
				enabled: [ application class dontClose not ] ];
		addItem: [ :item | 
			item
				name: 'Quit';
				action: [ application quit ] ];
		yourself
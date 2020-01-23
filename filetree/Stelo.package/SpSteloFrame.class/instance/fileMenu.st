private
fileMenu
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'New';
						action: [ application newProject ] ];
				addItem: [ :item | 
					item
						name: 'Open';
						action: [ application openProject ] ];
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
				action: [ application close ] ];
		addItem: [ :item | 
			item
				name: 'Quit';
				action: [ application quit ] ];
		yourself
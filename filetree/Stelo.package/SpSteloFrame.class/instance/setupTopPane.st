initialization
setupTopPane
	logo image: (ScratchTheme formAt: #scratchLogo).
	buttonOpen
		icon: (ScratchTheme formAt: #openButton);
		help: 'Open project'.
	buttonSave
		icon: (ScratchTheme formAt: #saveButton);
		help: 'Save this project'.
	menu
		addItem: [ :item | 
			item
				name: 'File' localized;
				subMenu: self fileMenu ];
		addItem: [ :item | 
			item
				name: 'Data' localized;
				subMenu: self dataMenu ];
		addItem: [ :item | 
			item
				name: 'Help' localized;
				subMenu: self helpMenu ].
	menu applyTo: self
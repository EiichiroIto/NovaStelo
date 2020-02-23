initialization
connectPresenters
	categories
		display: [ :each | each asCamelCase ];
		icons: [ :each | 
			ScratchTheme
				formAt: (each , 'Pressed') asSymbol
				ifAbsent: [ ScratchTheme formAt: #unknownPressed ] ];
		whenSelectionChangedDo: [ :each | self updateContents ]
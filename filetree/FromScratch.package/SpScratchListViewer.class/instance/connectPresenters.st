initialization
connectPresenters
	categories
		display: [ :each | each asCamelCase ];
		icons: [ :each | self markerFormFor: each ];
		whenSelectionChangedDo: [ :each | self updateContents ]
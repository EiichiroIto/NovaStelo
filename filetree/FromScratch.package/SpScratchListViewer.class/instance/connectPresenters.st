initialization
connectPresenters
	categories
		display: [ :each | each asString localized ];
		icons: [ :each | self markerFormFor: each ];
		whenSelectionChangedDo: [ :each | self updateContents ]
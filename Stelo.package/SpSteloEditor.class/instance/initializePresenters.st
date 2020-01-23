initialization
initializePresenters
	super initializePresenters.
	notebook addPage: self createPlotterPage.
	notebook whenSelectedPageChangedDo: [ :p | self pageSelected: p ]
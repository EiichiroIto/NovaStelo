accessing
plotterContents
	^ self plotterBase submorphs
		detect: [ :each | each isKindOf: SteloPlotterMorph ]
		ifNone: [ nil ]
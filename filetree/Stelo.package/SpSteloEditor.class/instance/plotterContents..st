accessing
plotterContents: aPlotterMorph
	| base |
	base := self plotterBase.
	base submorphs
		do: [ :each | 
			(each isKindOf: SteloPlotterMorph)
				ifTrue: [ each delete ] ].
	aPlotterMorph
		ifNotNil: [ base addMorph: aPlotterMorph ]
accessing
addPlots: aCollection
	self plotter
		ifNotNil: [ :morph | morph addPlots: aCollection ]
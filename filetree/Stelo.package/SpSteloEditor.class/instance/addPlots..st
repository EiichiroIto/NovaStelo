accessing
addPlots: aCollection
	self plotterContents
		ifNotNil: [ :morph | morph addPlots: aCollection ]
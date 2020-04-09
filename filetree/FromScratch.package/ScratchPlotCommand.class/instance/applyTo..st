operations
applyTo: aPlotter
	self isClearPlot
		ifTrue: [ ^ aPlotter clearPlots ].
	self isSetPlotYMax
		ifTrue: [ ^ aPlotter max: args first ].
	self isSetPlotYMin
		ifTrue: [ ^ aPlotter min: args first ]
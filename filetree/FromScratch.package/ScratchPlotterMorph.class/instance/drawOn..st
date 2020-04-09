drawing
drawOn: aCanvas
	super drawOn: aCanvas.
	self drawAxesOn: aCanvas.
	cache ifNil: [ ^ self ].
	self drawPlotDataOn: aCanvas
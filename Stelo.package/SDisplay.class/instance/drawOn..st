drawing
drawOn: aCanvas
	super drawOn: aCanvas.
	sworld ifNil: [ ^ aCanvas frameRectangle: self bounds color: Color red ].
	self modelChanged
		ifTrue: [ self updateCache ].
	self extent < modelExtent
		ifTrue: [ ^ self ].
	self drawWorldOn: aCanvas.
	self drawInfoOn: aCanvas.
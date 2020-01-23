accessing
modelBounds
	offset ifNil: [ ^ self bounds ].
	^ self topLeft + offset extent: modelExtent * cell
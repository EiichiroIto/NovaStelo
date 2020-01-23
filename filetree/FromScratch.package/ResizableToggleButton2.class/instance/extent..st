geometry
extent: aPoint

	super extent: aPoint.
	current ifNotNil: [current extent: aPoint].
	self updateLayout.
	iconMorph ifNotNil: [
		iconMorph position: self position + ((self extent - iconMorph extent) // 2)].

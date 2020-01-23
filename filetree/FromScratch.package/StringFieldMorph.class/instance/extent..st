geometry
extent: aPoint

	super extent: aPoint.
	stringMorph width: ((self width - (2 * borderWidth) - insetX) max: 0).

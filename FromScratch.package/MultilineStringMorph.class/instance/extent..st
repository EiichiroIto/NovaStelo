geometry
extent: aPoint

	| oldWidth |
	oldWidth := self width.
	super extent: (aPoint max: ((2 * borderWidth) + inset + 10)).
	self width ~= oldWidth ifTrue: [self wordWrapAll].


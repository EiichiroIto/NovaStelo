drawing
drawOn: aCanvas 

	| c |
	topBarBottom := self top + self topBarHeight.
	blockBottom := self bottom - 7.

	self computeHighlightColors.
	c := FormCanvas extent: self extent depth: 32.
	c := c copyOffset: self topLeft negated.
	self drawTopEdgeOn: c.
	self drawTopBarOn: c.
	self drawVerticalBarOn: c.
	self drawElseBarOn: c.
	self drawBottomBarOn: c.

	self drawFinalOn: aCanvas fromCanvas: c.

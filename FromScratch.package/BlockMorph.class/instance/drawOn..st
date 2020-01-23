drawing
drawOn: aCanvas 

	| c |
	self computeHighlightColors.
	c := FormCanvas extent: self extent depth: 32.
	c := c copyOffset: self topLeft negated.
	self isReporter ifTrue: [
		self drawSmoothTopEdgeOn: c.
		self drawReporterBodyOn: c.
		self drawSmoothBottomEdgeOn: c.
		^ self].

	self isStop ifTrue: [
		self drawTopEdgeOn: c.
		self drawStopBodyOn: c.
		self drawSmoothBottomEdgeOn: c.
		self drawFinalOn: aCanvas fromCanvas: c.
		^ self].

	self drawTopEdgeOn: c.
	self drawBodyOn: c.
	self drawBottomEdgeOn: c.

	self drawFinalOn: aCanvas fromCanvas: c.

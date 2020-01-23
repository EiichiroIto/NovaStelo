test
testPlottingBounds
	| p |
	p := self newPlotter.
	self assert: p plottingBounds isRectangle.
	self assert: p plottingBounds width > 0.
	self assert: p plottingBounds height > 0
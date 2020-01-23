drawing
drawVSliderOn: aCanvas
	"Draw a vertical slider on the given canvas."

	| x topY bottomY |
	sliderLength = self maxSliderLength ifTrue: [^ self].
	x := self left + sliderInsets left.
	topY := self top + sliderInsets top + sliderStart.
	bottomY := topY + sliderLength.
	self drawVEdge: sliderMiddleForm
		from: topY + sliderStartForm height
		to: (bottomY - sliderEndForm height)
		xOffset: sliderInsets left
		on: aCanvas.
	aCanvas translucentImage: sliderStartForm at: (x @ topY).
	aCanvas translucentImage: sliderEndForm at: (x @ (bottomY - sliderEndForm height + 1)).

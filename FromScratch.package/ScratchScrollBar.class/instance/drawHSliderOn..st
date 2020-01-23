drawing
drawHSliderOn: aCanvas
	"Draw a horizontal slider on the given canvas."

	| y leftX rightX |
	sliderLength = self maxSliderLength ifTrue: [^ self].
	y := self top + sliderInsets top.
	leftX := self left + sliderInsets left + sliderStart.
	rightX := leftX + sliderLength.
	self drawHEdge: sliderMiddleForm
		from: leftX + sliderStartForm width
		to: (rightX - sliderEndForm width)
		yOffset: sliderInsets top
		on: aCanvas.
	aCanvas translucentImage: sliderStartForm at: (leftX @ y).
	aCanvas translucentImage: sliderEndForm at: ((rightX - sliderEndForm width + 1) @ y).

drawing
drawAxesOn: aCanvas
	| str w |
	aCanvas
		frameRectangle: self plottingBounds
		color: ScratchTheme plotterFrameColor.
	self min
		ifNotNil: [ :num | 
			aCanvas
				drawString: num asString
				at: self plottingBounds bottomLeft + (-40 @ -15)
				font: self axisFont
				color: ScratchTheme plotterFrameColor ].
	self max
		ifNotNil: [ :num | 
			aCanvas
				drawString: num asString
				at: self plottingBounds topLeft + (-40 @ 5)
				font: self axisFont
				color: ScratchTheme plotterFrameColor ].
	self data
		ifNotNil: [ :list | 
			str := list size asString.
			w := self axisFont widthOfString: str.
			aCanvas
				drawString: str
				at: self plottingBounds bottomRight - (w @ 0)
				font: self axisFont
				color: ScratchTheme plotterFrameColor ]
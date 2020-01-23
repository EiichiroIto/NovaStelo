drawing
drawHLineFrom: startX to: endX y: yOffset color: c on: aCanvas

	| y |
	y := self top + yOffset.
	aCanvas
		fillRectangle: ((self left + startX)@y corner: (self left + endX)@(y + 1))
		color: c.

drawing
drawSmoothBottomEdgeOn: aCanvas

	| right y |
	right := self width - 1.
	y := self height - 3.

	self drawHLineFrom: 1 to: right - 1 y: y color: color on: aCanvas.
	self drawHLineFrom: 2 to: right - 2 y: y + 1 color: color on: aCanvas.
	self drawHLineFrom: 3 to: right - 2 y: y + 2 color: shadowColor on: aCanvas.

	self drawPoint: (right - 1)@y color: shadowColor on: aCanvas.
	self drawPoint: (right - 2)@(y + 1) color: shadowColor on: aCanvas.

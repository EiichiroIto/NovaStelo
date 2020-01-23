drawing
drawElseBarOn: aCanvas

	| left y |
	"these are in absolute coordinates"
	left := self left + CBlockBracketThickness - 1.
	y := self top + elseBarY.

	self drawInnerBottomY: y on: aCanvas.

	y := y + 2.
	aCanvas
		fillRectangle: (left@y corner: (self right - 1)@(y + self elseBarHeight))
		color: color.
	aCanvas
		fillRectangle: ((self right - 1)@y corner: self right@(y + self elseBarHeight))
		color: shadowColor.
	self drawInnerTopY: elseBarY + self elseBarHeight + 2 on: aCanvas.

drawing
drawInnerBottomY: y on: aCanvas

	| left barBottom |
	left := self left + CBlockBracketThickness - 1.
	barBottom := y + (CBlockBracketThickness - 3).

	"fill in bottom-left corner"
	aCanvas fillRectangle: (left@(y - 2) extent: 1@1) color: color.
	aCanvas fillRectangle: (left@(y - 1) extent: 2@1) color: color.
	aCanvas fillRectangle: (left@y extent: 3@1) color: color.

	aCanvas
		fillRectangle: ((left + 3)@y corner: (self right - 2)@(y + 1))
		color: highlightColor1.
	aCanvas
		fillRectangle: (left@(y + 1) corner: (self right - 1)@barBottom)
		color: color.
	aCanvas
		fillRectangle: ((self right - 1)@(y + 2) corner: self right@barBottom)
		color: shadowColor.



drawing
drawBottomBarOn: aCanvas 

	| left barTop barBottom |
	self isForever
		ifTrue: [
			barBottom := self bottom - 3.
			self drawSmoothBottomEdgeOn: aCanvas]
		ifFalse: [
			barBottom := self bottom - 7.
			self drawBottomEdgeOn: aCanvas].

	barTop := barBottom - (CBlockBracketThickness - 3).
	left := self left + CBlockBracketThickness - 1.

	"fill in bottom-left corner"
	aCanvas fillRectangle: (left@(barTop - 2) extent: 1@1) color: color.
	aCanvas fillRectangle: (left@(barTop - 1) extent: 2@1) color: color.
	aCanvas fillRectangle: (left@barTop extent: 3@1) color: color.

	aCanvas
		fillRectangle: ((left + 3)@barTop corner: (self right - 2)@(barTop + 1))
		color: highlightColor1.
	aCanvas
		fillRectangle: (left@(barTop + 1) corner: (self right - 1)@barBottom)
		color: color.
	aCanvas
		fillRectangle: ((self right - 1)@(barTop + 2) corner: self right@barBottom)
		color: shadowColor.



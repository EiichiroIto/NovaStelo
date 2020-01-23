drawing
drawFrameOn: aCanvas
	"Draw my edges and corners. Draw a simple border if any of my forms is nil."

	(topLeftForm isNil | topRightForm isNil | bottomLeftForm isNil | bottomRightForm isNil |
	 topEdgeForm isNil | leftEdgeForm isNil | rightEdgeForm isNil | bottomEdgeForm isNil)
		ifTrue: [^ aCanvas frameRectangle: self bounds width: 3 color: Color red].

	"draw edges"
	self drawTopEdgeOn: aCanvas.
	self drawLeftEdgeOn: aCanvas.
	self drawRightEdgeOn: aCanvas.
	self drawBottomEdgeOn: aCanvas.

	self drawCornersOn: aCanvas.


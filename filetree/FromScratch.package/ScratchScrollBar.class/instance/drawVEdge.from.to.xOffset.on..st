drawing
drawVEdge: aForm from: startY to: endY xOffset: xOffset on: aCanvas
	"Use the given form starting at the given point to draw a vertical edge between the given starting and ending y positions. Do nothing if the given form is nil."

	| x y |
	aForm ifNil: [^ self].
	x := bounds left + xOffset.
	y := startY.
	[y <= endY] whileTrue: [
		aCanvas translucentImage: aForm at: x@y.
		y := y + aForm height].

drawing
drawHEdge: aForm from: startX to: endX yOffset: yOffset on: aCanvas
	"Use the given form starting at the given point to draw a horizontal edge between the given starting and ending x positions. Do nothing if the given form is nil."

	| x y |
	aForm ifNil: [^ self].
	x := startX.
	y := bounds top + yOffset.
	[x <= endX] whileTrue: [
		aCanvas translucentImage: aForm at: x@y.
		x := x + aForm width].

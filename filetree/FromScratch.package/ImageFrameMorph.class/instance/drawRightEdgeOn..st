drawing
drawRightEdgeOn: aCanvas
	"Draw my right edge."

	| r f |
	r := ((myBox right - rightEdgeForm width) @ (myBox top + topRightForm height)) corner: (myBox right @ (myBox bottom - bottomRightForm height)).
	(r intersects: aCanvas clipRect) ifFalse: [^ self].

	f := edgeCache at: 4.
	(f isNil or: [f extent ~= r extent]) ifTrue: [
		f := Form extent: r extent depth: 32.
		0 to: r height by: rightEdgeForm height do: [:y | rightEdgeForm displayOn: f at: 0@y rule: Form over].
		edgeCache at: 4 put: f].

	aCanvas translucentImage: f at: r topLeft.


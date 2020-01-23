drawing
drawTopEdgeOn: aCanvas
	"Draw my top edge."

	| r f |
	r := ((myBox left + topLeftForm width) @ myBox top) corner: ((myBox right - topRightForm width) @ (myBox top + topEdgeForm height)).
	(r intersects: aCanvas clipRect) ifFalse: [^ self].

	f := edgeCache at: 2.
	(f isNil or: [f extent ~= r extent]) ifTrue: [
		f := Form extent: r extent depth: 32.
		0 to: r width by: topEdgeForm width do: [:x | topEdgeForm displayOn: f at: x@0 rule: Form over].
		edgeCache at: 2 put: f].

	aCanvas translucentImage: f at: r topLeft.

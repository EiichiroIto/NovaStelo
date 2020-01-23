drawing
drawBottomEdgeOn: aCanvas
	"Draw my bottom edge."

	| r f |
	r := ((myBox left + topLeftForm width) @ (myBox bottom - bottomEdgeForm height)) corner: ((myBox right - bottomRightForm width) @ myBox bottom).
	(r intersects: aCanvas clipRect) ifFalse: [^ self].

	f := edgeCache at: 3.
	(f isNil or: [f extent ~= r extent]) ifTrue: [
		f := Form extent: r extent depth: 32.
		0 to: r width by: bottomEdgeForm width do: [:x | bottomEdgeForm displayOn: f at: x@0 rule: Form over].
		edgeCache at: 3 put: f].

	aCanvas translucentImage: f at: r topLeft.

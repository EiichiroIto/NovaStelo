drawing
drawLeftEdgeOn: aCanvas
	"Draw my left edge."

	| r f |
	r := (myBox left @ (myBox top + topLeftForm height)) corner: ((myBox left + leftEdgeForm width) @ (myBox bottom - bottomLeftForm height)).
	(r intersects: aCanvas clipRect) ifFalse: [^ self].

	f := edgeCache at: 1.
	(f isNil or: [f extent ~= r extent]) ifTrue: [
		f := Form extent: r extent depth: 32.
		0 to: r height by: leftEdgeForm height do: [:y | leftEdgeForm displayOn: f at: 0@y rule: Form over].
		edgeCache at: 1 put: f].

	aCanvas translucentImage: f at: r topLeft.

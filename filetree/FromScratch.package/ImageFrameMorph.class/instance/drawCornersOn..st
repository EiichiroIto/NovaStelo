drawing
drawCornersOn: aCanvas
	"Draw my corners if they intersect the canvas clipping box."

	| clipR p |
	clipR := aCanvas clipRect.

	p := myBox topLeft.
	((p extent: topLeftForm extent) intersects: clipR) ifTrue: [
		aCanvas translucentImage: topLeftForm at: p].

	p := (myBox right - topRightForm width)@myBox top.
	((p extent: topRightForm extent) intersects: clipR) ifTrue: [
		aCanvas translucentImage: topRightForm at: p].

	p := myBox left@(myBox bottom - bottomLeftForm height).
	((p extent: bottomLeftForm extent) intersects: clipR) ifTrue: [
		aCanvas translucentImage: bottomLeftForm at: p].

	p := (myBox right - bottomRightForm width)@(myBox bottom - bottomRightForm height).
	((p extent: bottomRightForm extent) intersects: clipR) ifTrue: [
		aCanvas translucentImage: bottomRightForm at: p].

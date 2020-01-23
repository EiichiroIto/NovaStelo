intialization
initFromForm: aForm
	"Initialize myself by cutting up the given Form. The corners are taken to extend to one pixel short of the center in each dimension. A one-pixel strip from the center of each edge will be replicated to stretch the edge. The color of the center pixel of the rectangle will be used as the fill color. (You can suppress color filling by setting my color to transparent after calling this method)."

	| cornerExtent center |
	cornerExtent := (aForm extent - 1) // 2.
	center := aForm extent // 2.

	topLeftForm := (aForm copy: (0@0 extent: cornerExtent)).
	topRightForm := (aForm copy: ((aForm width - cornerExtent x) @ 0 extent: cornerExtent)).
	bottomLeftForm := (aForm copy: (0 @ (aForm height - cornerExtent y) extent: cornerExtent)).
	bottomRightForm := (aForm copy: ((aForm extent - cornerExtent) extent: cornerExtent)).

	topEdgeForm := (aForm copy: ((center x@0) extent: (1 @ cornerExtent y))).
	leftEdgeForm := (aForm copy: ((0 @ center y) extent: (cornerExtent x @ 1))).
	rightEdgeForm := (aForm copy: (((aForm width - cornerExtent x) @ center y) extent: (cornerExtent x @ 1))).
	bottomEdgeForm := (aForm copy: ((center x@(aForm height - cornerExtent y)) extent: (1 @ cornerExtent y))).

	color := aForm colorAt: center.

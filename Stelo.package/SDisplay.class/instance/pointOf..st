private
pointOf: aPoint
	| p |
	p := (aPoint - offset) // cell - (modelExtent // 2) + (0 @ 1).
	^ p x @ p y negated
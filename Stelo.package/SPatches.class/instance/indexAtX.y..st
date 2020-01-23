accessing
indexAtX: x y: y
	| x1 y1 |
	x1 := self normalize: x.
	y1 := self normalize: y.
	^ self indexAtPoint: x1 @ y1
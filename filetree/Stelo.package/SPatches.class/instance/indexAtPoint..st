private
indexAtPoint: aPoint
	| r c |
	c := aPoint x floor + (order // 2) + 1.
	r := aPoint y floor + (order // 2) + 1.
	^ self indexAtCol: c row: r
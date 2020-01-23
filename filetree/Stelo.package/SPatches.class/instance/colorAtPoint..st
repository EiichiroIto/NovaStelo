accessing
colorAtPoint: aPoint
	| index |
	index := self indexAtPoint: aPoint.
	^ self colorAt: index
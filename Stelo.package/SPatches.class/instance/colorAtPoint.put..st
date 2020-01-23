accessing
colorAtPoint: aPoint put: anInteger
	| index |
	index := self indexAtPoint: aPoint.
	self colorAt: index put: anInteger
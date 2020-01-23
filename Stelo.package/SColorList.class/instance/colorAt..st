accessing
colorAt: anInteger
	| index |
	index := self normalize: anInteger.
	^ colors at: index + 1
accessing
forceSize: anInteger
	self privFixedSize: anInteger.
	array := array
		ifNil: [ self arrayClass new: self fixedSize ]
		ifNotNil: [ array forceTo: self fixedSize paddingWith: 0 ].
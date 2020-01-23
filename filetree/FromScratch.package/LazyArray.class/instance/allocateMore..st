private
allocateMore: anInteger
	| newSize |
	self assert: self fixedSize isNil.
	newSize := anInteger roundUpTo: self defaultAllocationSize.
	array := array
		ifNil: [ self arrayClass new: newSize ]
		ifNotNil: [ array grownBy: newSize ].
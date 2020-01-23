instance creation
data: anObject
	self assert: anObject isLiteral.
	^ self basicNew
		initialize;
		data: anObject;
		yourself
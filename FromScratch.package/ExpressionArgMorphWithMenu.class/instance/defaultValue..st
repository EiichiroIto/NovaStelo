accessing
defaultValue: anObject
	(anObject isKindOf: String)
		ifTrue: [self specialValue: anObject]
		ifFalse: [super defaultValue: anObject].
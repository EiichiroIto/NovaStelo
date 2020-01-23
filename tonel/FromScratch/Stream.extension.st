Extension { #name : #Stream }

{ #category : #'*FromScratch' }
Stream >> skipSeparators [
	[self atEnd]
		whileFalse:
		[self next isSeparator ifFalse: [^ self position: self position-1]]
]

accessing
subHatBlockNamed: aString
	^ self subBlocks detect: [ :each | each subName = aString ] ifNone: [ nil ]
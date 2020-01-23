accessing
stringOf: anInteger
	^ anInteger = 0
		ifTrue: [ '' ]
		ifFalse: [ literals at: anInteger ]
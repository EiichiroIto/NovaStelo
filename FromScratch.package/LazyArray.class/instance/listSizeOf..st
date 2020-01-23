accessing
listSizeOf: anInteger
	(anInteger between: 1 and: self size)
		ifFalse: [ ^ 0 ].
	^ (array at: anInteger) size
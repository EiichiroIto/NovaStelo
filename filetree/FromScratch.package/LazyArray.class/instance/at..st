accessing
at: anInteger
	anInteger > self size
		ifTrue: [ ^ self defaultValue ].
	^ array at: anInteger
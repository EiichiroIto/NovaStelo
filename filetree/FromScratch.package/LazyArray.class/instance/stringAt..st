accessing
stringAt: anInteger
	self assert: className = #StringArray.
	anInteger > self size
		ifTrue: [ ^ self defaultValue ].
	^ array stringAt: anInteger
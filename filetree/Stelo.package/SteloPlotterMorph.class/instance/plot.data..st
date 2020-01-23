accessing
plot: anInteger data: aFloat
	self ensurePenExists: anInteger.
	(last isNil or: [ (last at: anInteger) notNil ])
		ifTrue: [ self newData ].
	last at: anInteger put: aFloat
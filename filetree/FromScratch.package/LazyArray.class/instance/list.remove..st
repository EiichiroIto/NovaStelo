accessing
list: anInteger1 remove: anInteger2
	| arr |
	anInteger1 = 0
		ifTrue: [ ^ self ].
	self assureExistsIndex: anInteger1 and: 0.
	arr := array at: anInteger1.
	(anInteger2 > arr size or: [ anInteger2 = 0 ])
		ifTrue: [ ^ self ].
	arr removeAt: anInteger2
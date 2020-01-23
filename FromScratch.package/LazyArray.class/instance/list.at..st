accessing
list: anInteger1 at: anInteger2
	| arr |
	anInteger1 = 0
		ifTrue: [ ^ self defaultValue ].
	self assert: className = #Array.
	anInteger1 > self size
		ifTrue: [ self assureExistsIndex: anInteger1 ].
	arr := array at: anInteger1.
	(arr isNil or: [ anInteger2 > arr size ])
		ifTrue: [ ^ self defaultValue ].
	^ arr at: anInteger2
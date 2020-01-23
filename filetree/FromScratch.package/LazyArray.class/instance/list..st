accessing
list: anInteger1
	| ret |
	(anInteger1 = 0 or: [ anInteger1 > self size ])
		ifTrue: [ ^ Array new ].
	ret := array at: anInteger1.
	ret ifNil: [ ^ Array new ].
	^ ret asArray
private
push: anObject
	| x |
	x := anObject.
	x = true
		ifTrue: [ x := 1 ].
	x = false
		ifTrue: [ x := 0 ].
	stack add: x.
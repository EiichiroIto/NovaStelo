command
turtle: bno x: x y: y exceptBreed: myBno index: myIndex
	| list |
	list := (self breedOf: bno) breedsAtPoint: x @ y.
	bno = myBno
		ifTrue: [ list remove: myIndex ifAbsent: [  ] ].
	^ list isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ list anyOne ].
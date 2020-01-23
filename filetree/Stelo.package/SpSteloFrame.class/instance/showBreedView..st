menu actions
showBreedView: aPoint
	| bno id |
	bno := self currentBreedNo.
	id := self sworld
		turtle: bno
		x: aPoint x
		y: aPoint y
		exceptBreed: 0
		index: 0.
	id = 0
		ifTrue: [ ^ self ].
	self showBreedNo: bno at: id
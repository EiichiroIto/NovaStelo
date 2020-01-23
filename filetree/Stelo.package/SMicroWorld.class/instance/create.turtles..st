accessing
create: bid turtles: anInteger
	bid < SBreedId defaultUserNo
		ifTrue: [ self error: 'breedId must be more than 2' ].
	^ (breeds at: bid) create: anInteger
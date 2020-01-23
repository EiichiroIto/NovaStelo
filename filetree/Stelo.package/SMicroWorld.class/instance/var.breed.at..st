accessing variable
var: anInteger breed: bid at: id
	^ bid = SBreedId observerBreedNo
		ifTrue: [ self observer var: anInteger at: id sworld: self ]
		ifFalse: [ (breeds at: bid) var: anInteger at: id ]
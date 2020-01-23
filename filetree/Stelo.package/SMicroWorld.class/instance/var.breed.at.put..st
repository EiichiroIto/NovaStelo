accessing variable
var: anInteger breed: bid at: id put: aNumber
	bid = SBreedId observerBreedNo
		ifTrue: [ self observer
				var: anInteger
				at: id
				put: aNumber
				sworld: self ]
		ifFalse: [ (breeds at: bid) var: anInteger at: id put: aNumber ]
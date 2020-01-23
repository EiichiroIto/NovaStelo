accessing variable
var: anInteger breed: bid putAll: anObject
	bid = SBreedId observerBreedNo
		ifTrue: [ self error: 'cannot set variables to observer' ]
		ifFalse: [ (breeds at: bid) var: anInteger putAll: anObject ]
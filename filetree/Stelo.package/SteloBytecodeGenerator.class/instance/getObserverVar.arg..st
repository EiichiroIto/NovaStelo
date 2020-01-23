variable ops
getObserverVar: vid arg: anInteger
	self appendValue: anInteger.
	self appendValue: vid.
	self appendValue: SBreedId observerBreedNo.
	self appendSymbol: #getBreedVar.
	^ nil
patch ops
changeObserverVar: v by: aNumber
	self appendValue: 1.
	self appendValue: 1.
	self appendValue: v.
	self appendValue: SBreedId observerBreedNo.
	self appendSymbol: #getBreedVar.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendValue: v.
	self appendValue: SBreedId observerBreedNo.
	self appendSymbol: #setBreedVarTo
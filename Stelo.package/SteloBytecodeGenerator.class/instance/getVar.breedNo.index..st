turtle  ops
getVar: aBlock1 breedNo: aBlock2 index: index
	| bno |
	self appendValue: index.
	bno := aBlock2 value.
	self appendValue: (aBlock1 value: bno).
	self appendValue: bno.
	self appendSymbol: #getBreedVar.
	^ nil
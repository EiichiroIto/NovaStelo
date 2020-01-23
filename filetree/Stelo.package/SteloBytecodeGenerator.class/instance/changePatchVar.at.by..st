patch ops
changePatchVar: v at: pno by: aNumber
	self appendValue: pno.
	self appendSymbol: #dup.
	self appendValue: v.
	self appendValue: SBreedId patchBreedNo.
	self appendSymbol: #getBreedVar.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendValue: v.
	self appendValue: SBreedId patchBreedNo.
	self appendSymbol: #setBreedVarTo.
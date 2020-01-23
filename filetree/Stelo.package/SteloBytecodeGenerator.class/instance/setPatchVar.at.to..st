patch ops
setPatchVar: var at: pno to: aNumber
	self appendValue: pno.
	self appendValue: aNumber.
	self appendValue: var.
	self appendValue: SBreedId patchBreedNo.
	self appendSymbol: #setBreedVarTo.
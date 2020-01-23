patch ops
getPatchVar: vid at: pno
	self appendValue: pno.
	self appendValue: vid.
	self appendValue: SBreedId patchBreedNo.
	self appendSymbol: #getBreedVar.
	^ nil
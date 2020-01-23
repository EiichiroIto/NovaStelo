observer ops
clearAll
	self unaryCommand: #clearBreed arg: SBreedId patchBreedNo.
	self nullaryCommand: #clearTurtles.
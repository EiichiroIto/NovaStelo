test
testSetBreedVarTo
	| w t v |
	w := self newWorld.
	t := self newThread: w.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	self assert: (w patches privVariables var: v at: 1) equals: 0.
	self assert: t stack size equals: 0.
	t push: 1.
	t push: 2.
	t push: v.
	t push: SBreedId patchBreedNo.
	t setBreedVarTo.
	self assert: (w patches privVariables var: v at: 1) equals: 2.
	self assert: t stack size equals: 0.
	t push: 1.
	t push: 3.
	t push: v.
	t push: SBreedId patchBreedNo.
	t setBreedVarTo.
	self assert: (w patches privVariables var: v at: 1) equals: 3.
	self assert: t stack size equals: 0.
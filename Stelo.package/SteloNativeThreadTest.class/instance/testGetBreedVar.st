test
testGetBreedVar
	| w t v |
	w := self newWorld.
	t := self newThread: w.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	t push: 1.
	t push: v.
	t push: SBreedId patchBreedNo.
	t getBreedVar.
	self assert: t pop equals: 0.
	w patches privVariables var: v at: 1 put: 2.
	t push: 1.
	t push: v.
	t push: SBreedId patchBreedNo.
	t getBreedVar.
	self assert: t pop equals: 2
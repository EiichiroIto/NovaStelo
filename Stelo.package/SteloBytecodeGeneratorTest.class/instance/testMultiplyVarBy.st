test
testMultiplyVarBy
	| w v b t |
	w := self newWorld.
	w createPatch: 3.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b multiplyVar: v by: 2.
	w patches var: v at: 1 put: 1.
	w patches var: v at: 5 put: 2.
	w patches var: v at: 7 put: 3.
	w patches var: v at: 8 put: 4.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assertCollection: (w patches privVariables realArrayAt: v)
		equals: #(2 0 0 0 4 0 6 8 0) asFloatArray
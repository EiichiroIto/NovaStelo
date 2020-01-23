test
testNsumVarTo
	| w v1 v2 b t |
	w := self newWorld.
	w createPatch: 4.
	v1 := w patches addVariable: 'a'.
	v2 := w patches addVariable: 'b'.
	b := self newGenerator.
	b nsumVar: v1 to: v2.
	"
0 1 0 0     4 1 5 4
0 0 1 0 --> 3 4 3 1
0 2 0 0     5 1 6 4
0 0 0 3     6 3 6 0
"
	w patches var: v1 at: 2 put: 1.
	w patches var: v1 at: 7 put: 1.
	w patches var: v1 at: 10 put: 2.
	w patches var: v1 at: 16 put: 3.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assertCollection: (w patches privVariables realArrayAt: v2)
		equals: #(4 1 5 4 3 4 3 1 5 1 6 4 6 3 6 0) asFloatArray
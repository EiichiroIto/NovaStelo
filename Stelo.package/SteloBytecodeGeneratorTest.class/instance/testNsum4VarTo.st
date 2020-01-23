test
testNsum4VarTo
	| w v1 v2 b t |
	w := self newWorld.
	w createPatch: 4.
	v1 := w patches addVariable: 'a'.
	v2 := w patches addVariable: 'b'.
	b := self newGenerator.
	b nsum4Var: v1 to: v2.
	"
0 1 0 0     1 0 2 3
0 0 1 0 --> 0 4 0 1
0 2 0 0     2 0 3 3
0 0 0 3     3 3 3 0
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
		equals: #(1 0 2 3 0 4 0 1 2 0 3 3 3 3 3 0) asFloatArray
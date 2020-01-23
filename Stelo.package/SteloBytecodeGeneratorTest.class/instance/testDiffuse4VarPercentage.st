test
testDiffuse4VarPercentage
	| w b v t arr |
	w := self newWorld.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b diffuse4Var: v percentage: 80.

	"
10  0  0  0    2  2  0  2
 0  0  0  0    2  0  0  0
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    2  0  0  0
"
	w patches var: v at: 1 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 2 0 2 2 0 0 0 0 0 0 0 2 0 0 0) asFloatArray.

	"
 0  0  0 10    2  0  2  2
 0  0  0  0    0  0  0  2
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    0  0  0  2
"
	w patches privVariables clearVarNo: v.
	w patches var: v at: 4 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 0 2 2 0 0 0 2 0 0 0 0 0 0 0 2) asFloatArray.

	"
 0  0  0  0    2  0  0  0
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 2  0  0  0
10  0  0  0    2  2  0  2
"
	w patches privVariables clearVarNo: v.
	w patches var: v at: 13 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 0 0 0 0 0 0 0 2 0 0 0 2 2 0 2) asFloatArray.

	"
 0  0  0  0    0  0  0  2
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 0  0  0  2
 0  0  0 10    2  0  2  2
"
	w patches privVariables clearVarNo: v.
	w patches var: v at: 16 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(0 0 0 2 0 0 0 0 0 0 0 2 2 0 2 2) asFloatArray.
	w createPatch: 3.
	w patches privVariables clearVarNo: v.
	w patches var: v at: 5 put: 100.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(0 20 0 20 20 20 0 20 0) asFloatArray
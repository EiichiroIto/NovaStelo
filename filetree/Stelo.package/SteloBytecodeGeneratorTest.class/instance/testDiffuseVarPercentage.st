test
testDiffuseVarPercentage
	| w b v t arr |
	w := self newWorld.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b diffuseVar: v percentage: 80.

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
		equals: #(2 1 0 1 1 1 0 1 0 0 0 0 1 1 0 1) asFloatArray.

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
		equals: #(1 0 1 2 1 0 1 1 0 0 0 0 1 0 1 1) asFloatArray.

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
		equals: #(1 1 0 1 0 0 0 0 1 1 0 1 2 1 0 1) asFloatArray.

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
		equals: #(1 0 1 1 0 0 0 0 1 0 1 1 1 0 1 2) asFloatArray.
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
		equals: #(10 10 10 10 20 10 10 10 10) asFloatArray
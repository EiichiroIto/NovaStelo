tests-command
testMultiplyByVarNo
	| ps v |
	ps := SPatches new.
	ps create: 3.
	v := ps addVariable: 'a'.
	ps var: v at: 3 put: 2.
	ps var: v at: 4 put: 3.
	ps var: v at: 5 put: 5.
	ps var: v at: 8 put: 11.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 0 2 3 5 0 0 11 0) asFloatArray.
	ps multiplyBy: 7 varNo: v.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 0 14 21 35 0 0 77 0) asFloatArray
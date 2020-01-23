tests-command
testDiffuse4VarNo
	| ps v |
	ps := SPatches new.
	ps create: 3.
	v := ps addVariable: 'a'.
	ps var: v at: 5 put: 100.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 0 0 0 100 0 0 0 0) asFloatArray.
	ps diffuse4: 80 varNo: v.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 20 0 20 20 20 0 20 0) asFloatArray
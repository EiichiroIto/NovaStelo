tests-command
testNsum4To
	| ps v1 v2 |
	ps := SPatches new.
	ps create: 3.
	v1 := ps addVariable: 'a'.
	v2 := ps addVariable: 'b'.
	ps var: v1 at: 2 put: 2.
	ps var: v1 at: 7 put: 1.
	self
		assertCollection: (ps privVariables realArrayAt: v1)
		equals: #(0 2 0 0 0 0 1 0 0) asFloatArray.
	ps nsum4: v1 to: v2.
	self
		assertCollection: (ps privVariables realArrayAt: v2)
		equals: #(3 0 2 1 2 0 0 3 1) asFloatArray
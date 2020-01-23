tests-command
testVarAtPut
	| br a |
	br := SBreed new.
	a := br addVariable: 'a'.
	br privVariables forceSize: 2.
	self assert: ((br privVariables privVars at: a) at: 1) equals: 0.
	self assert: ((br privVariables privVars at: a) at: 2) equals: 0.
	br var: a at: 1 put: 1.
	br var: a at: 2 put: 3.
	self assert: ((br privVariables privVars at: a) at: 1) equals: 1.
	self assert: ((br privVariables privVars at: a) at: 2) equals: 3.
	br var: a at: 1 put: 5.
	br var: a at: 2 put: 2.
	self assert: ((br privVariables privVars at: a) at: 1) equals: 5.
	self assert: ((br privVariables privVars at: a) at: 2) equals: 2
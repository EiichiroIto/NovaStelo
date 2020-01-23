tests-accessing variable
testVarAt
	| ps |
	ps := SPatches new.
	ps clear.
	ps create: 4.
	self assert: (ps var: SPatchVarDef xVarNo at: 1) equals: -2.
	self assert: (ps var: SPatchVarDef xVarNo at: 2) equals: -1.
	self assert: (ps var: SPatchVarDef xVarNo at: 8) equals: 1.
	self assert: (ps var: SPatchVarDef xVarNo at: 9) equals: -2.
	self assert: (ps var: SPatchVarDef yVarNo at: 1) equals: -2.
	self assert: (ps var: SPatchVarDef yVarNo at: 2) equals: -2.
	self assert: (ps var: SPatchVarDef yVarNo at: 13) equals: 1.
	self assert: (ps var: SPatchVarDef yVarNo at: 14) equals: 1.
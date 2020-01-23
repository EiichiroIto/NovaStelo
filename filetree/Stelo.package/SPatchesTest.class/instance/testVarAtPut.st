tests-accessing variable
testVarAtPut
	| ps |
	ps := SPatches new.
	ps clear.
	ps create: 2.
	ps var: SPatchVarDef screenVarNo at: 1 put: 2.
	ps var: SPatchVarDef screenVarNo at: 2 put: 5.
	ps var: SPatchVarDef colorVarNo at: 1 put: 100.
	ps var: SPatchVarDef colorVarNo at: 2 put: 200.
	self assert: (ps var: SPatchVarDef screenVarNo at: 1) equals: 2.
	self assert: (ps var: SPatchVarDef screenVarNo at: 2) equals: 5.
	self assert: (ps colorAt: 1) equals: 100.
	self assert: (ps colorAt: 2) equals: (SColorList default normalize: 200).
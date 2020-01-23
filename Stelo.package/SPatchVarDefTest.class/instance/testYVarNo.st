tests-accessing
testYVarNo
	| v |
	v := SPatchVarDef new.
	self assert: (v varNoFor: 'y') equals: SPatchVarDef yVarNo.
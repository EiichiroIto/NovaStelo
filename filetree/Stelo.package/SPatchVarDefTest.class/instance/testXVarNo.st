tests-accessing
testXVarNo
	| v |
	v := SPatchVarDef new.
	self assert: (v varNoFor: 'x') equals: SPatchVarDef xVarNo.
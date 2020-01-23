tests-accessing
testScreenVarNo
	| v |
	v := SPatchVarDef new.
	self assert: (v varNoFor: 'screen') equals: SPatchVarDef screenVarNo.
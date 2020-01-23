tests-accessing
testColorVarNo
	| v |
	v := SPatchVarDef new.
	self assert: (v varNoFor: 'color') equals: SPatchVarDef colorVarNo.
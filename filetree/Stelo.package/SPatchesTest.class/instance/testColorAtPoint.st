tests-accessing
testColorAtPoint
	| ps |
	ps := SPatches new.
	ps create: 3.
	ps privVariables setVar: SPatchVarDef colorVarNo toArray: #[2 0 0 0 1 0 0 3 4].
	self assert: (ps colorAtPoint: 0 @ 0) equals: 1.
	self assert: (ps colorAtPoint: -1 @ -1) equals: 2.
	self assert: (ps colorAtPoint: 0 @ 1) equals: 3.
	self assert: (ps colorAtPoint: 1 @ 1) equals: 4.
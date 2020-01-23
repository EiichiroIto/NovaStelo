tests-accessing
testColors
	| ps |
	ps := SPatches new.
	ps create: 3.
	self assert: ps colors size equals: 9.
	self assert: (ps colors allSatisfy: [ :each | each = 0 ]).
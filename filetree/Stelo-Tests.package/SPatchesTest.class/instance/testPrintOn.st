tests-printing
testPrintOn
	| ps |
	ps := SPatches new.
	self assert: ps asString equals: 'Patches(100x100)'.
	ps create: 10.
	self assert: ps asString equals: 'Patches(10x10)'.
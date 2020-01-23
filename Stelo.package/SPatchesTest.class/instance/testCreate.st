tests-command
testCreate
	| ps |
	ps := SPatches new.
	ps create: 4.
	self assert: (ps privVariables realArrayAt: 1) size equals: 16.
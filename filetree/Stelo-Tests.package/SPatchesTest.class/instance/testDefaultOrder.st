tests-private
testDefaultOrder
	| ps |
	ps := SPatches new.
	self assert: ps defaultOrder equals: 100.
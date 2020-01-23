tests-accessing
testCountAlive
	| ps |
	ps := SPatches new.
	ps create: 5.
	self assert: ps countAlive equals: 25.
	ps create: 10.
	self assert: ps countAlive equals: 100.
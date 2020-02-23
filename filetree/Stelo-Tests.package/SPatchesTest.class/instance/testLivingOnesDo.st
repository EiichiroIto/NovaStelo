tests-enumerating
testLivingOnesDo
	| ps count |
	ps := SPatches new.
	ps create: 5.
	count := 0.
	ps livingOnesDo: [ :each | count := count + 1 ].
	self assert: count equals: 25.
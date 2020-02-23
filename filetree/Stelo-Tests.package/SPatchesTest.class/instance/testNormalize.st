tests-accessing
testNormalize
	| ps r |
	ps := SPatches new.
	ps create: 7.
	-3 to: 3 do: [ :each | 
		r := ps normalize: each.
		self assert: r equals: each ].
	r := ps normalize: -4.
	self assert: r equals: 3.
	r := ps normalize: -5.
	self assert: r equals: 2.
	r := ps normalize: -7.
	self assert: r equals: 0.
	r := ps normalize: -10.
	self assert: r equals: -3.
	r := ps normalize: -11.
	self assert: r equals: 3.
	r := ps normalize: 4.
	self assert: r equals: -3.
	r := ps normalize: 5.
	self assert: r equals: -2.
	r := ps normalize: 7.
	self assert: r equals: 0.
	r := ps normalize: 10.
	self assert: r equals: 3.
	r := ps normalize: 11.
	self assert: r equals: -3.
	ps create: 8.
	-4 to: 3 do: [ :each | 
		r := ps normalize: each.
		self assert: r equals: each ].
	r := ps normalize: -5.
	self assert: r equals: 3.
	r := ps normalize: -8.
	self assert: r equals: 0.
	r := ps normalize: -12.
	self assert: r equals: -4.
	r := ps normalize: -13.
	self assert: r equals: 3.
	r := ps normalize: 4.
	self assert: r equals: -4.
	r := ps normalize: 8.
	self assert: r equals: 0.
	r := ps normalize: 11.
	self assert: r equals: 3.
	r := ps normalize: 12.
	self assert: r equals: -4.
	ps create: 100.
	r := ps normalize: 49.
	self assert: r equals: 49.
	r := ps normalize: 49.1.
	self assert: r equals: 49.1.
	r := ps normalize: -49.9.
	self assert: r closeTo: -49.9.
	r := ps normalize: -50.
	self assert: r equals: -50.
	r := ps normalize: -50.1.
	self assert: r equals: 49.9.
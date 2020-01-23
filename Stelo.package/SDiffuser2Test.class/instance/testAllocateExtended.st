tests-private
testAllocateExtended
	| d x |
	d := SDiffuser2 new.
	self assert: d privExtended isNil.
	d allocateExtended: 25.
	self assert: (d privExtended isKindOf: FloatArray).
	self assert: d privExtended size equals: 25.
	x := d privExtended.
	d allocateExtended: 20.
	self assert: d privExtended equals: x.
	self assert: d privExtended size equals: 25.
	d allocateExtended: 30.
	self assert: d privExtended ~= x.
	self assert: d privExtended size equals: 30.
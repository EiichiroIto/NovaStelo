tests-private
testSetupExtended
	| d |
	d := SDiffuser2 new.
	d privOrder: 4.
	d allocateExtended: 36.
	d setupExtended: #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16).
	self assert: (d privExtended isKindOf: FloatArray).
	self assertCollection: d privExtended size equals: 36.
	self
		assertCollection: d privExtended
		equals:
			#(0 0 0 0 0 0 0 1 2 3 4 0 0 5 6 7 8 0 0 9 10 11 12 0 0 13 14 15 16 0 0 0 0 0 0 0)
				asFloatArray
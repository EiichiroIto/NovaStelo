tests-private
testSetupBorder
	| d |
	d := SDiffuser2 new.
	d privOrder: 4.
	d privExtended: #(
	 0  0  0  0  0  0
	 0  1  2  3  4  0
	 0  5  6  7  8  0
	 0  9 10 11 12  0
	 0 13 14 15 16  0
	 0  0  0  0  0  0) asFloatArray.
	d setupBorder.
	self
		assertCollection: d privExtended
		equals: #(
		16 13 14 15 16 13
		 4  1  2  3  4  1
		 8  5  6  7  8  5
	 	12  9 10 11 12  9
		16 13 14 15 16 13
		 4  1  2  3  4  1) asFloatArray
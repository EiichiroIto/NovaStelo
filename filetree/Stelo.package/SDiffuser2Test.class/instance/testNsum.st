tests-private
testNsum
	| d x |
	d := SDiffuser2 new.
	d privOrder: 4.
	d setupNeighbor.
	d privNeighborSize: 8.
"
 1  2  3  0  1  2
 3  0  1  2  3  0    16 10 12 10
 3  2  1  0  3  2 -> 10  9 16 12
 1  0  1  3  2  0    14 10  9 11
 2  3  1  0  1  2     8 12 14 11
 1  0  2  3  1  0
"
	x := FloatArray new: 16.
	d privExtended: #(1 2 3 0 1 2 3 0 1 2 3 0 3 2 1 0 3 2 1 0 1 3 2 0 2 3 1 0 1 2 1 0 2 3 1 0) asFloatArray.
	d nsum: x.
	self assertCollection: x equals: #(16 10 12 10 10 9 16 12 14 10 9 11 8 12 14 11) asFloatArray.
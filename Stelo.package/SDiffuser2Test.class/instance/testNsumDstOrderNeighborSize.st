tests-accessing
testNsumDstOrderNeighborSize
	| d x |
	d := SDiffuser2 new.
	"
0 0 0 0    0 5 0 0
0 5 0 0 -> 5 0 5 0
0 0 0 0    0 5 0 0
0 0 0 0    0 0 0 0
"
	x := FloatArray new: 16.
	d nsum: #(0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0) asFloatArray dst: x order: 4 neighborSize: 4.
	self assertCollection: x equals: #(0 5 0 0 5 0 5 0 0 5 0 0 0 0 0 0) asFloatArray.
	"
0 1 0 0    1 0 2 3
0 0 1 0 -> 0 4 0 1
0 2 0 0    2 0 3 3
0 0 0 3    3 3 3 0
"
	x := FloatArray new: 16.
	d nsum: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray dst: x order: 4 neighborSize: 4.
	self assertCollection: x equals: #(1 0 2 3 0 4 0 1 2 0 3 3 3 3 3 0) asFloatArray.

	d := SDiffuser2 new.
	"
0 0 0 0    5 5 5 0
0 5 0 0 -> 5 0 5 0
0 0 0 0    5 5 5 0
0 0 0 0    0 0 0 0
"
	x := FloatArray new: 16.
	d nsum: #(0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0) asFloatArray dst: x order: 4 neighborSize: 8.
	self assertCollection: x equals: #(5 5 5 0 5 0 5 0 5 5 5 0 0 0 0 0) asFloatArray.
	"
0 1 0 0    4 1 5 4
0 0 1 0 -> 3 4 3 1
0 2 0 0    5 1 6 4
0 0 0 3    6 3 6 0
"
	x := FloatArray new: 16.
	d nsum: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray dst: x order: 4 neighborSize: 8.
	self assertCollection: x equals: #(4 1 5 4 3 4 3 1 5 1 6 4 6 3 6 0) asFloatArray
tests-accessing
testDiffuseOrderPercentNeighborSize
	| d x |
	d := SDiffuser2 new.
	x := FloatArray newFrom: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0).
	d diffuse: x order: 4 percent: 80 neighborSize: 8.
	self assertCollection: x equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"0 0  0 0    0 1  1 1
 0 0 10 0 -> 0 1  2 1
 0 0  0 0    0 1  1 1
 0 0  0 0    0 0  0 0"
	x := FloatArray newFrom: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0).
	d diffuse: x order: 4 percent: 80 neighborSize: 8.
	self assertCollection: x equals: #(0 1 1 1 0 1 2 1 0 1 1 1 0 0 0 0) asFloatArray.
"0 0 0 0    0 0 0 0
 0 0 0 0    1 1 0 1
10 0 0 0 -> 2 1 0 1
 0 0 0 0    1 1 0 1"
	x := FloatArray newFrom: #(0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0).
	d diffuse: x order: 4 percent: 80 neighborSize: 8.
	self assertCollection: x equals: #(0 0 0 0 1 1 0 1 2 1 0 1 1 1 0 1) asFloatArray.
"0 0 0 0    1 1 0 1
 0 0 0 0    0 0 0 0
 0 0 0 0 -> 1 1 0 1
10 0 0 0    2 1 0 1"
	x := FloatArray newFrom: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0).
	d diffuse: x order: 4 percent: 80 neighborSize: 8.
	self assertCollection: x equals: #(1 1 0 1 0 0 0 0 1 1 0 1 2 1 0 1) asFloatArray.

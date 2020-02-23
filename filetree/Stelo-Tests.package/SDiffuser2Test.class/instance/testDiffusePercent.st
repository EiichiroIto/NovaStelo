tests-private
testDiffusePercent
	| d |
	d := SDiffuser2 new.
	d privOrder: 4.
	d privNeighborSize: 8.
	d setupNeighbor.
"            0 0 0 0 0 0
 0 0  0 0    0 0 1 1 1 0
 0 0 10 0 -> 0 0 1 2 1 0
 0 0  0 0    0 0 1 1 1 0
 0 0  0 0    0 0 0 0 0 0
             0 0 0 0 0 0
"
	d allocateExtended: 36.
	d diffuse: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"            0 0 0 0 0 0
 0  0 0 0    0 0 0 0 0 0
 0  0 0 0 -> 0 1 1 1 0 0
 0 10 0 0    0 1 2 1 0 0
 0  0 0 0    0 1 1 1 0 0
             0 0 0 0 0 0
"
	d clearExtended.
	d diffuse: #(0 0 0 0 0 0 0 0 0 10 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0) asFloatArray.
"             0 0 0 0 0 0
 0  0  0 0    0 0 1 1 1 0
 0  0 10 0 -> 0 1 2 3 1 0
 0 10  0 0    0 1 3 2 1 0
 0  0  0 0    0 1 1 1 0 0
              0 0 0 0 0 0
"
	d clearExtended.
	d diffuse: #(0 0 0 0 0 0 10 0 0 10 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 1 1 1 0 0 1 2 3 1 0 0 1 3 2 1 0 0 1 1 1 0 0 0 0 0 0 0 0) asFloatArray.
"           0 0 0 0 0 0
 0 0 0 0    0 0 0 0 0 0
 0 0 0 0    1 1 1 0 0 0
10 0 0 0 -> 1 2 1 0 0 0
 0 0 0 0    1 1 1 0 0 0
            0 0 0 0 0 0
"
	d clearExtended.
	d diffuse: #(0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0) asFloatArray.
"           0 0 0 0 0 0
 0 0 0 0    0 0 0 0 0 0
 0 0 0 0    0 0 0 0 0 0
 0 0 0 0 -> 1 1 1 0 0 0
10 0 0 0    1 2 1 0 0 0
            1 1 1 0 0 0
"
	d clearExtended.
	d diffuse: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0) asFloatArray.

	d := SDiffuser2 new.
	d privOrder: 4.
	d privNeighborSize: 4.
	d setupNeighbor.
"            0 0 0 0 0 0
 0 0  0 0    0 0 0 2 0 0
 0 0 10 0 -> 0 0 2 2 2 0
 0 0  0 0    0 0 0 2 0 0
 0 0  0 0    0 0 0 0 0 0
             0 0 0 0 0 0
"
	d allocateExtended: 36.
	d diffuse: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 0 2 0 0 0 0 2 2 2 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
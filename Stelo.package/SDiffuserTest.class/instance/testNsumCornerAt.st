tests-private
testNsumCornerAt
	| d |
	d := SDiffuser neighbor4.
	d rows: 4 cols: 4.
"
0 1 0 0    1 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #topLeft.
	self assertCollection: d result equals: #(1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 3
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #topRight.
	self assertCollection: d result equals: #(0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
1 2 0 0    0 0 0 0
0 0 0 3    4 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 1 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #bottomLeft.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0) asFloatArray.
"
0 1 1 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 2    0 0 0 0
1 0 0 3    0 0 0 3
"
	d privSrc: #(0 1 1 0 0 0 1 0 0 2 0 2 1 0 0 3) asFloatArray.
	d nsumCornerAt: #bottomRight.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3) asFloatArray.

	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
0 1 0 0    4 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #topLeft.
	self assertCollection: d result equals: #(4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 4
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #topRight.
	self assertCollection: d result equals: #(0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
1 2 0 0    0 0 0 0
0 0 0 3    7 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 1 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #bottomLeft.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 7 0 0 0) asFloatArray.
"
0 1 1 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 2    0 0 0 0
1 0 0 3    0 0 0 1
"
	d privSrc: #(0 1 1 0 0 0 1 0 0 2 0 2 1 0 0 3) asFloatArray.
	d nsumCornerAt: #bottomRight.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4) asFloatArray.
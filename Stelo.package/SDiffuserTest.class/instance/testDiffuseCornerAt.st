tests-private
testDiffuseCornerAt
	| d |
	d := SDiffuser neighbor4.
	d rows: 4 cols: 4.
"
10  0  0  0    2  2  0  2
 0  0  0  0    2  0  0  0
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    2  0  0  0
"
	d privSrc: #(10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #topLeft.
	self assertCollection: d result equals: #(2 2 0 2 2 0 0 0 0 0 0 0 2 0 0 0) asFloatArray.
"
 0  0  0 10    2  0  2  2
 0  0  0  0    0  0  0  2
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    0  0  0  2
"
	d privSrc: #(0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #topRight.
	self assertCollection: d result equals: #(2 0 2 2 0 0 0 2 0 0 0 0 0 0 0 2) asFloatArray.
"
 0  0  0  0    2  0  0  0
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 2  0  0  0
10  0  0  0    2  2  0  2
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #bottomLeft.
	self assertCollection: d result equals: #(2 0 0 0 0 0 0 0 2 0 0 0 2 2 0 2) asFloatArray.
"
 0  0  0  0    0  0  0  2
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 0  0  0  2
 0  0  0 10    2  0  2  2
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10) asFloatArray.
	d diffuseCorner: 80 at: #bottomRight.
	self assertCollection: d result equals: #(0 0 0 2 0 0 0 0 0 0 0 2 2 0 2 2) asFloatArray.

	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
10  0  0  0    2  1  0  1
 0  0  0  0    1  1  0  1
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    1  1  0  1
"
	d privSrc: #(10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #topLeft.
	self assertCollection: d result equals: #(2 1 0 1 1 1 0 1 0 0 0 0 1 1 0 1) asFloatArray.
"
 0  0  0 10    1  0  1  2
 0  0  0  0    1  0  1  1
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    1  0  1  1
"
	d privSrc: #(0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #topRight.
	self assertCollection: d result equals: #(1 0 1 2 1 0 1 1 0 0 0 0 1 0 1 1) asFloatArray.
"
 0  0  0  0    1  1  0  1
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 1  1  0  1
10  0  0  0    2  1  0  1
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #bottomLeft.
	self assertCollection: d result equals: #(1 1 0 1 0 0 0 0 1 1 0 1 2 1 0 1) asFloatArray.
"
 0  0  0  0    1  0  1  1
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 1  0  1  1
 0  0  0 10    1  0  1  2
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10) asFloatArray.
	d diffuseCorner: 80 at: #bottomRight.
	self assertCollection: d result equals: #(1 0 1 1 0 0 0 0 1 0 1 1 1 0 1 2) asFloatArray.
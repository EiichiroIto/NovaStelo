tests-accessing
testDiffuseArray
	| d ret |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.

	ret := d diffuse: 80 array: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	self assertCollection: ret equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"0 0  0 0    0 1  1 1
 0 0 10 0 -> 0 1  2 1
 0 0  0 0    0 1  1 1
 0 0  0 0    0 0  0 0"
	ret := d diffuse: 80 array: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0) asFloatArray.
	self assertCollection: ret equals: #(0 1 1 1 0 1 2 1 0 1 1 1 0 0 0 0) asFloatArray.
"0 0 0 0    0 0 0 0
 0 0 0 0    1 1 0 1
10 0 0 0 -> 2 1 0 1
 0 0 0 0    1 1 0 1"
	ret := d diffuse: 80 array: #(0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0) asFloatArray.
	self assertCollection: ret equals: #(0 0 0 0 1 1 0 1 2 1 0 1 1 1 0 1) asFloatArray.
"0 0 0 0    1 1 0 1
 0 0 0 0    0 0 0 0
 0 0 0 0 -> 1 1 0 1
10 0 0 0    2 1 0 1"
	ret := d diffuse: 80 array: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0) asFloatArray.
	self assertCollection: ret equals: #(1 1 0 1 0 0 0 0 1 1 0 1 2 1 0 1) asFloatArray.
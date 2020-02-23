tests-private
testDiffuseBorderAt
	| d |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
 0  0  0  0    1  0  1  1
 0  0  0 10    1  0  1  2
 0  0  0  0 -> 1  0  1  1
 0  0  0  0    0  0  0  0
"
	d privSrc: #(0 0 0 0 0 0 0 10 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseBorder: 80 at: #right.
	self assertCollection: d result equals: #(1 0 1 1 1 0 1 2 1 0 1 1 0 0 0 0) asFloatArray.
"
 0  0 10  0    0  1  2  1
 0  0  0  0    0  1  1  1
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    0  1  1  1
"
	d privSrc: #(0 0 10 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseBorder: 80 at: #top.
	self assertCollection: d result equals: #(0 1 2 1 0 1 1 1 0 0 0 0 0 1 1 1) asFloatArray.
"0 0 0 0    0 0 0 0
 0 0 0 0    1 1 0 1
10 0 0 0 -> 2 1 0 1
 0 0 0 0    1 1 0 1"
	d privSrc: #(0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0) asFloatArray.
	d diffuseBorder: 80 at: #left.
	self assertCollection: d result equals: #(0 0 0 0 1 1 0 1 2 1 0 1 1 1 0 1) asFloatArray.
"
 0  0  0  0     1  1  1  0
 0  0  0  0 ->  0  0  0  0
 0  0  0  0     1  1  1  0
 0 10  0  0     1  2  1  0
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 0 10 0 0) asFloatArray.
	d diffuseBorder: 80 at: #bottom.
	self assertCollection: d result equals: #(1 1 1 0 0 0 0 0 1 1 1 0 1 2 1 0) asFloatArray.
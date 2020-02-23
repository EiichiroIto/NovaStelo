tests-private
testNsumBorderAt
	| d  |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
0 1 0 0    0 1 5 0
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumBorderAt: #top.
	self assertCollection: d result equals: #(0 1 5 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 3 0 0 0
0 2 0 0    5 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc:  #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumBorderAt: #left.
	self assertCollection: d result equals: #(0 0 0 0 3 0 0 0 5 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 0 0 0 2
1 2 0 0    0 0 0 5
0 0 0 3    0 0 0 0
"
	d privSrc:  #(0 1 0 0 0 0 1 0 1 2 0 0 0 0 0 3) asFloatArray.
	d nsumBorderAt: #right.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 2 0 0 0 5 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 3 6 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumBorderAt: #bottom.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 3 6 0) asFloatArray.
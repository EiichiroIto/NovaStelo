tests-accessing
testNsum
	| d ret |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
0 0 0 0    5 5 5 0
0 5 0 0 -> 5 0 5 0
0 0 0 0    5 5 5 0
0 0 0 0    0 0 0 0
"
	ret := d nsum: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	self assertCollection: ret equals: #(4 1 5 4 3 4 3 1 5 1 6 4 6 3 6 0) asFloatArray.
"
0 1 0 0    4 1 5 4
0 0 1 0 -> 3 4 3 1
0 2 0 0    5 1 6 4
0 0 0 3    6 3 6 0
"
	ret := d nsum: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	self assertCollection: ret equals: #(4 1 5 4 3 4 3 1 5 1 6 4 6 3 6 0) asFloatArray.
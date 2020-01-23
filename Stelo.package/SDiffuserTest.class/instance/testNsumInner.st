tests-private
testNsumInner
	| d |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
0 0 0 0    0 0 0 0
0 0 1 0 -> 0 3 2 0
0 2 0 0    0 1 3 0
0 0 0 0    0 0 0 0
"
	d privSrc: #(0 0 0 0 0 0 1 0 0 2 0 0 0 0 0 0) asFloatArray.
	d nsumInner.
	self assertCollection: d result equals: #(0 0 0 0 0 3 2 0 0 1 3 0 0 0 0 0) asFloatArray.
tests-private
testDiffuseInner
	| d |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.

	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0).
	d diffuseInner: 80.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"0 0  0 0    0 1  1 1
 0 0 10 0 -> 0 1  2 1
 0 0  0 0    0 1  1 1
 0 0  0 0    0 0  0 0"
	d privSrc: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0).
	d diffuseInner: 80.
	self assertCollection: d result equals: #(0 1 1 1 0 1 2 1 0 1 1 1 0 0 0 0) asFloatArray.
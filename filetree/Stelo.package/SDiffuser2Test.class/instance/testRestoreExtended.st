tests-private
testRestoreExtended
	| d x |
	x := FloatArray new: 16.
	d := SDiffuser2 new.
	d privOrder: 4.
	d privExtended: #(0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d restoreExtended: x.
	self assertCollection: x equals: #(0 1 1 1 0 1 2 1 0 1 1 1 0 0 0 0) asFloatArray.
"
1 0 1 2 3 0
1 2 3 0 1 2     5  6  2  3
3 0 1 2 3 0 ->  0  1  2  6
1 2 3 0 1 2     4  3  0  2
3 2 1 0 3 2     4  2  2 10
1 0 3 2 1 1
"
	d privExtended: #(1 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 2 1 0 3 2 1 0 3 2 1 1) asFloatArray.
	d restoreExtended: x.
	self assertCollection: x equals: #(5 6 2 4 0 1 2 6 4 3 0 2 4 2 2 10) asFloatArray.

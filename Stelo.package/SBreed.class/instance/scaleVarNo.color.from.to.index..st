microworld
scaleVarNo: vid color: anInteger from: aNumber1 to: aNumber2 index: id
	| v c |
	v := variables var: vid at: id.
	c := self
		scaleValue: v
		color: anInteger
		from: aNumber1
		to: aNumber2.
	self colorAt: id put: c
accessing
normalize: aNumber
	| h x |
	x := aNumber.
	h := order / 2.
	x := x \\ order.
	x >= h ifTrue: [ x := x - order ].
	^ x
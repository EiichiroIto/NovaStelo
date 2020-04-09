test
testWhenMouseClicked
	| p x a b |
	p := self newPlotter.
	self assert: p whenMouseClicked isNil.
	x := 0.
	a := b := nil.
	p
		whenMouseClicked: [ :obj :evt | 
			x := 1.
			a := obj.
			b := evt ].
	self assert: p whenMouseClicked isBlock.
	self assert: x equals: 0.
	p click: 5.
	self assert: x equals: 1.
	self assert: (a isKindOf: ScratchPlotterMorph).
	self assert: b equals: 5
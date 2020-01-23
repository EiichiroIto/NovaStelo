private
plottingDataAt: anInteger
	| ret min1 max1 list ratio h |
	h := self plottingBounds height.
	min1 := min ifNil: [ self minData ].
	max1 := max ifNil: [ self maxData ].
	(min1 isNil or: [ max1 isNil ])
		ifTrue: [ ^ nil ].
	list := data at: anInteger.
	list size < pens size
		ifTrue: [ list := list grownBy: pens size - list size ].
	^ list
		collect: [ :each | 
			each
				ifNotNil: [ ratio := (max1 closeTo: min1)
						ifTrue: [ 0.5 ]
						ifFalse: [ ((each - min1) / (max1 - min1)) asFloat ].
					ret := 0 interpolateTo: h at: ratio.
					ret := 0 max: ret.
					ret := h min: ret.
					ret ] ]
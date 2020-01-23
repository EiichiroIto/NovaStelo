drawing
drawPlotDataOn: aCanvas
	| from x p2 y |
	from := Array new: pens size.
	x := self plottingBounds left.
	y := self plottingBounds bottom.
	cache
		do: [ :list | 
			list
				withIndexDo: [ :each :index | 
					each
						ifNotNil: [ p2 := x @ (y - each).
							(from at: index)
								ifNotNil: [ :p1 | aCanvas line: p1 to: p2 color: (pens at: index) ].
							from at: index put: p2 ] ].
			x := x + 1 ]
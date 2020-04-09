drawing
drawPlotDataOn: aCanvas
	| from x p2 y c drawMarker |
	from := Array new: pens size.
	x := self plottingBounds left.
	y := self plottingBounds bottom.
	drawMarker := self useMarker
		ifTrue: [ [ :p :c1 | 
			aCanvas
				fillRectangle: (Rectangle center: p extent: self markerExtent)
				color: c1 ] ]
		ifFalse: [ [ :p :c1 |  ] ].
	cache
		do: [ :list | 
			list
				withIndexDo: [ :each :index | 
					each
						ifNotNil: [ p2 := x @ (y - each).
							c := pens at: index.
							drawMarker cull: p2 cull: c.
							(from at: index)
								ifNotNil: [ :p1 | aCanvas line: p1 to: p2 color: c ].
							from at: index put: p2 ] ].
			x := x + 1 ]
drawing
drawWorldOn: aCanvas
	| x0 x y colors index tc |
	colors := sworld colors.
	x0 := self left + offset x.
	y := self top + offset y + (cell y * (modelExtent y - 1)).
	index := 1.
	modelExtent y
		timesRepeat: [ x := x0.
			modelExtent x
				timesRepeat: [ tc := SColorList colorAt: (colors at: index).
					aCanvas fillRectangle: (x @ y extent: cell) color: tc.
					index := index + 1.
					x := x + cell x ].
			y := y - cell y ].
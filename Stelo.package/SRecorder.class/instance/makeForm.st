private
makeForm
	| form x0 x y colors index tc frame |
	self modelChanged
		ifTrue: [ self updateCache ].
	form := ColorForm extent: extent depth: 32.
	frame := AnimatedImageFrame new
		delay: self defaultFrameDelay;
		form: form.
	colors := microworld colors.
	x0 := offset x.
	y := offset y + (cell y * (modelExtent y - 1)).
	index := 1.
	modelExtent y
		timesRepeat: [ x := x0.
			modelExtent x
				timesRepeat: [ tc := SColorList colorAt: (colors at: index).
					form fill: (x @ y extent: cell) fillColor: tc.
					index := index + 1.
					x := x + cell x ].
			y := y - cell y ].
	^ frame
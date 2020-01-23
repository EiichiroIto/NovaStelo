command
forward: aNumber breed: bid id: anInteger
	| c x y delta dx dy penDown rest h d ps ts |
	ps := breeds at: SBreedId patchBreedNo.
	ts := breeds at: bid.
	penDown := ts penDownAt: anInteger.
	c := ts colorAt: anInteger.
	x := ts xAt: anInteger.
	y := ts yAt: anInteger.
	h := ts headingAt: anInteger.
	delta := Point r: 1.0 degrees: h.
	dx := delta x.
	dy := delta y.
	aNumber truncated
		timesRepeat: [ penDown
				ifTrue: [ ps colorAtPoint: x @ y put: c ].
			x := x + dx.
			y := y + dy.
			x := ps normalize: x.
			y := ps normalize: y ].
	penDown
		ifTrue: [ ps colorAtPoint: x @ y put: c ].
	rest := aNumber - aNumber truncated.
	(rest closeTo: 0.0)
		ifFalse: [ d := Point r: rest degrees: h.
			x := x + d x.
			y := y + d y.
			x := ps normalize: x.
			y := ps normalize: y ].
	ts xAt: anInteger put: x.
	ts yAt: anInteger put: y
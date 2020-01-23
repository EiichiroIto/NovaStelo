private
contentsBounds
	"Answer a rectangle that encloses the bounds of all my submorphs."

	| offset r |
	offset := contents topLeft negated.
	r := 0@0 extent: 1@1.
	contents submorphsDo: [:m |
		r := r quickMerge: (m fullBounds translateBy: offset) truncated].
	^ r

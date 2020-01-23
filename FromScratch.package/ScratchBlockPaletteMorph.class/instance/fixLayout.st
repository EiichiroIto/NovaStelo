other
fixLayout
	"Right align the blocks in the palette if RTL is set to true. The watcher toggle checkbox buttons are assumed to be about 18 pixels wide."

	| offset r |
	owner ifNil: [ ^ self ].
	offset := self topLeft negated.
	r := 0 @ 0 extent: 1 @ 1.
	self
		submorphsDo:
			[ :m | r := r quickMerge: (m fullBounds translateBy: offset) truncated ].
	self width: (r width max: owner width)
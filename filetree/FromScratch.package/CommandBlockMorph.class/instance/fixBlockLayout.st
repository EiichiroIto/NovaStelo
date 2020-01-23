private
fixBlockLayout
	"Update the positions of my submorphs."

	| isFirst h x minXForArgs hAdjust nextB w oldPos oldExtent |
	blockLayoutNeeded
		ifFalse: [ ^ self ].
	super fixBlockLayout.
	oldPos := self position.
	oldExtent := self extent.
	hAdjust := 4.
	isFirst := true.
	h := 14.	"minimum height"
	self nonControlFlowSubmorphs
		do: [ :m | 
			(m isBlockMorph)
				ifTrue: [ m fixBlockLayout ].
			(m isArgMorph)
				ifTrue: [ m fixArgLayout ].
			(isFirst and: [ (m isKindOf: StringMorph) not ])
				ifTrue: [ "extra space when an arg overlaps with notch"
					h := h max: m height + 3.
					hAdjust := 1 ].
			isFirst := false.
			h := h max: m height ].
	((self isCBlock) or: [ self isIfElseBlock ])
		ifTrue: [ minXForArgs := self left + PuzzleInset + PuzzleWidth + 8 ]
		ifFalse: [ minXForArgs := self left ].
	h := h + 10.
	self isReporter
		ifTrue: [ h := h - 2.
			hAdjust := 2 ].
	self isStop
		ifTrue: [ h := h - 5.
			hAdjust := 0 ].
	x := self left + 5.
	self nonControlFlowSubmorphs
		do: [ :m | 
			(m isKindOf: StringMorph)
				ifTrue: [ m color: self labelColor ]
				ifFalse: [ x := x max: minXForArgs ].
			m position: x @ (self top + ((h - hAdjust - m height) // 2)).
			x := x + m width + 4 ].
	w := x - self left max: 37.
	(self isCBlock or: [ self isIfElseBlock ])
		ifTrue: [ w := w max: 71 ].
	self extent: w @ h.
	(nextB := self nextBlock)
		ifNotNil: [ self isCBlock
				ifFalse: [ nextB position: self left @ (self bottom - 4) ].
			nextB fixBlockLayout ]
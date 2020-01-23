other
fixBlockLayout
	"Update the positions of my submorphs."

	| mList maxH h x y |
	blockLayoutNeeded ifFalse: [^ self].
	cachedForm := nil.
	cachedFeedbackForm := nil.

	mList := self nonControlFlowSubmorphs.
	maxH := 0.
	mList do: [:m |
		(m isKindOf: ArgMorph) ifTrue: [m fixArgLayout].
		(m isKindOf: BlockMorph) ifTrue: [m fixBlockLayout].
		maxH := maxH max: m height].
	h := (maxH + 4) max: 17.

	x := isBoolean ifTrue: [8] ifFalse: [4].
	(mList size > 0 and: [mList first isKindOf: StringMorph]) ifTrue: [x := x + 2].

	mList do: [:m |
		(m isKindOf: StringMorph) ifTrue: [m color: self labelColor].
		y := (h - m height) // 2.
		m position: self position + (x@y).
		x := x + m width + 3].
	x := x + (isBoolean ifTrue: [1] ifFalse: [-3]).

	self extent: (x + 4) @ h.
	(self meOrOwnerThatIsA: ScratchBlockPaletteMorph) ifNotNil: [
		(self meOrOwnerThatIsA: ScratchBlockPaletteMorph) fixLayout].

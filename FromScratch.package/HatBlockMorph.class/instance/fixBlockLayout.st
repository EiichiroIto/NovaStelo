private
fixBlockLayout
	"Update the positions of my submorphs."

	| x centerY nextB nonBlockSubmorphs oldExtent oldPos |
	blockLayoutNeeded
		ifFalse: [ ^ self ].
	super fixBlockLayout.
	oldExtent := self extent.
	oldPos := self position.
	x := self left + 8.
	centerY := self top + 25.
	self nonControlFlowSubmorphs
		do: [ :m | 
			m isArgMorph
				ifTrue: [ m fixArgLayout ].
			m position: x @ (centerY - (m height // 2)).
			x := x + m width + 5 ].
	x + x + 4.
	self width: (x - self left max: self hatTopForm width).
	nonBlockSubmorphs := self submorphs
		select: [ :m | m isBlockMorph not or: [ m isArgMorph ] ].
	self
		height:
			self hatTopForm height
				+
					(nonBlockSubmorphs
						inject: CBlockBracketThickness
						into: [ :h :m | h max: m height + 8 ]).
	(nextB := self nextBlock)
		ifNotNil: [ nextB left: self left.
			nextB top: self bottom - 4.
			nextB fixBlockLayout ]
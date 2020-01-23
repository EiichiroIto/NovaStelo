private
topBarHeight
	"Answer the height of the top bar."

	| nonBlockSubmorphs |
	nonBlockSubmorphs := self submorphs select: [:m |
		(m isKindOf: BlockMorph) not or: [argMorphs includes: m]].
	^ nonBlockSubmorphs inject: CBlockBracketThickness into: [:h :m | h max: (m height + 4)].


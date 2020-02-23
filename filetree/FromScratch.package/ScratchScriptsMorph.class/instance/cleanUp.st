event handling
cleanUp
	"Align all scripts vertically in alphabetical order"

	| sortedBlocks y |
	y := 20.
	(owner isKindOf: ScrollFrameMorph2)
		ifTrue: [ owner hScrollPixels: 0.
			owner vScrollPixels: 0 ].
	sortedBlocks := (submorphs select: #isBlockMorph)
		sort: [ :s1 :s2 | s1 top < s2 top ].
	sortedBlocks
		do: [ :s | 
			s position: self position + (20 @ y).
			y := y + s fullBounds height + 15 ].
	self layoutChanged
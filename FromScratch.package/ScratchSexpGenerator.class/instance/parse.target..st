accessing
parse: aTopBlock target: aMorph
	targetMorph := aMorph.
	parser parseBlock: aTopBlock.
	^ stream contents
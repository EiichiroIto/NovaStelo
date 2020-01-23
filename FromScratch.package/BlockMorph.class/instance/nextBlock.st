block enumerating
nextBlock
	"Answer the block myself in the block sequence or nil if I am the last block in the sequence. Each block is a submorph of the previous block."

	^ self submorphs detect: [:m | m isBlockMorph] ifNone: [nil]

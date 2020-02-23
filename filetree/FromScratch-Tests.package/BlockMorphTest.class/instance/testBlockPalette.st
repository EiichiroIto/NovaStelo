test
testBlockPalette
	| b1 b2 b3 s |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	self assert: b1 blockPalette isNil.
	self assert: b2 blockPalette isNil.
	self assert: b3 blockPalette isNil.
	s := ScratchBlockPaletteMorph new.
	s addMorph: b1.
	self assert: b1 blockPalette equals: s.
	self assert: b2 blockPalette equals: s.
	self assert: b3 blockPalette equals: s.
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	s := ScratchScriptsMorph new.
	s addMorph: b1.
	self assert: b1 blockPalette isNil.
	self assert: b2 blockPalette isNil.
	self assert: b3 blockPalette isNil
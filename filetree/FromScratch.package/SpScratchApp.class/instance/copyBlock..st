menu actions
copyBlock: aBlockMorph
	| code |
	code := self serializeBlocks: aBlockMorph.
	self class clipboard: code
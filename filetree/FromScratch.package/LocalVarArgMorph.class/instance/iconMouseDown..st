event handling
iconMouseDown: anEvent
	| morph |
	self blockPalette ifNotNil: [ ^ self ].
	morph := self newLocalVarBlockMorph.
	anEvent hand grabMorph: morph.
	morph center: anEvent hand position
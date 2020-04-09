private
serializeBlocks: aTopBlock
	| code |
	code := ScratchSexpGenerator new parse: aTopBlock initialIndent: 1.
	aTopBlock isHatBlock
		ifFalse: [ code := '(' , code , ')' ].
	^ code
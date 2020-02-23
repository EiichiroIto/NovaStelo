menu actions
duplicateBlock: aBlockMorph
	| code lex list obj |
	code := ScratchSexpGenerator new parse: aBlockMorph initialIndent: 1.
	aBlockMorph isHatBlock
		ifFalse: [ code := '(' , code , ')' ].
	lex := SexpLexer new read: code.
	list := SexpParser new parse: lex.
	obj := (ScratchSexpImporter appName: self appName)
		importCode: list
		into: self target.
	obj ifNil: [ ^ self ].
	obj position: ActiveHand position.
	ActiveHand grabMorph: obj
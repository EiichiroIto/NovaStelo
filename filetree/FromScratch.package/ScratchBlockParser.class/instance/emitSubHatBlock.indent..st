code generator
emitSubHatBlock: aMorph indent: indent
	| str i2 |
	str := aMorph subName.
	str isEmpty
		ifTrue: [ ^ self ].
	codeGenerator generateSubHeader: str.
	aMorph nextBlock
		ifNotNil: [ i2 := indent + (codeGenerator indentLevelFor: str).
			self emitGlobalVars: aMorph varNames indent: i2.
			self emitCode: aMorph nextBlock indent: i2 ].
	codeGenerator generateSubFooter: str
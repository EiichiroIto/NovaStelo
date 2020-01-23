code generator
emitEventHatBlock: aMorph indent: indent
	| str |
	str := aMorph eventName.
	str isEmpty ifTrue: [^ self].
	codeGenerator generateEventHeader: str.
	aMorph nextBlock
		ifNotNil: [self
				emitCode: aMorph nextBlock
				indent: indent + (codeGenerator indentLevelFor: str)].
	codeGenerator generateEventFooter: str.
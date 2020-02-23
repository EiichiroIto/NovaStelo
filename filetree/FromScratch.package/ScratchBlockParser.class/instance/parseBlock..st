accessing
parseBlock: aTopBlock
	aTopBlock emitCode: self indent: 0.
	aTopBlock isHatBlock
		ifFalse: [ aTopBlock nextBlock
				ifNotNil: [ self emitCode: aTopBlock nextBlock indent: 0 ] ]
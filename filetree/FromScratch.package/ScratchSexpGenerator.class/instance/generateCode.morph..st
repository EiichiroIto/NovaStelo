code generator
generateCode: aSymbol morph: aBlockMorph
	self
		printOpenParen;
		printString: aSymbol.
	aBlockMorph blockArgs
		do: [ :each | 
			self
				printSpace;
				printString: (each argString: parser) ].
	self printCloseParen.
	self generateLineFeed
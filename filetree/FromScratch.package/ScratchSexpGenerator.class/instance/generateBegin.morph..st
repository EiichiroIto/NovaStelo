code generator
generateBegin: aSymbol morph: aMorph
	self
		printOpenParen;
		printString: aSymbol.
	aMorph blockArgs
		do: [ :each | 
			self
				printSpace;
				printString: (each argString: parser) ].
	self generateLineFeed.
	self printOpenParen
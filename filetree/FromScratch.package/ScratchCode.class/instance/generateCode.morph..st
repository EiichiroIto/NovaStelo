code generator
generateCode: aSymbol morph: aMorph
	self class addCommand: aSymbol.
	SpScratchApp
		try: [ self perform: aSymbol withArguments: aMorph blockArgs ]
		onFailure: [ aMorph showBalloon: 'error' ]
code generator
generateReporter: aSymbol morph: aMorph
	| ret |
	self class addCommand: aSymbol.
	ret := 0.
	SpScratchApp
		try: [ ret := self
				perform: aSymbol asSymbol
				withArguments: aMorph blockArgs ]
		onFailure: [ aMorph showBalloon: 'Error!' localized ].
	^ ret
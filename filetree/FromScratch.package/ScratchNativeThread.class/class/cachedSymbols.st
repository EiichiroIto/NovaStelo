private
cachedSymbols
	cachedSymbols ifNil: [ self setupCachedSymbols ].
	^ cachedSymbols
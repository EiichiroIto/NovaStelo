accessing
blockSpecAt: aSymbol
	^ blockSpecs at: aSymbol ifAbsent: [ nil ]
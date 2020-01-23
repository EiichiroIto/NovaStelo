accessing
blockColorAt: aSymbol
	^ blockColors at: aSymbol ifAbsent: [ Color red ]
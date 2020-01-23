accessing
formAt: aSymbol ifAbsent: aBlock
	^ forms at: aSymbol asSymbol ifAbsent: aBlock
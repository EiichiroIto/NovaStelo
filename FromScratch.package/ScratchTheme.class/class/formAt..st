accessing
formAt: aSymbolOrString
	^ self formAt: aSymbolOrString ifAbsent: [ self error ]
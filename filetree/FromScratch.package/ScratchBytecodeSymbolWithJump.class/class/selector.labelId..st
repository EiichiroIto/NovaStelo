instance creation
selector: aSymbol labelId: anInteger
	^ self basicNew
		initialize;
		selector: aSymbol;
		labelId: anInteger;
		yourself
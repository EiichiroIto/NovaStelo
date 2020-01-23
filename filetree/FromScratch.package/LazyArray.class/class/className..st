instance creation
className: aSymbol
	^ self basicNew
		initialize;
		className: aSymbol;
		yourself
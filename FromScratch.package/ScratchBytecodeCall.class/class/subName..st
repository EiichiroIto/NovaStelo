instance creation
subName: aString
	^ self basicNew
		initialize;
		subName: aString;
		yourself
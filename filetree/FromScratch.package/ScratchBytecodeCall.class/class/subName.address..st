instance creation
subName: aString address: anInteger
	^ self basicNew
		initialize;
		subName: aString;
		address: anInteger;
		yourself
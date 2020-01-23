instance creation
appName: aString
	^ self basicNew
		initialize;
		appName: aString;
		yourself
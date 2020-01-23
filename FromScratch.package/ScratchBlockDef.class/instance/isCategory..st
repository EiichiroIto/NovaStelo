testing
isCategory: aString
	^ aString isString and: [ (self isSpacer: aString) not ]
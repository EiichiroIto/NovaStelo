code generator
generateEventHeader: aString
	"self generateLineFeed."
	self
		printOpenParen;
		printString: 'when';
		printSpace;
		printString: aString.
	self generateLineFeed.
	self printOpenParen
code generator
generateSubHeader: aString
	self generateLineFeed.
	self
		printOpenParen;
		printString: 'sub';
		printSpace;
		printString: aString.
	self generateLineFeed.
	self printOpenParen
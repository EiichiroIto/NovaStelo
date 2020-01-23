*FromScratch
stringWidth: aString
	^(((self fontToUse widthOfString: aString) max: self minimumWidth) + (self layoutInset * 2)) ceiling
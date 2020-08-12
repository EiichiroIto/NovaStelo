test
testFonts
	| t |
	t := self newTranslator.
	self assert: t fonts isDictionary.
	self assert: t fonts isEmpty	
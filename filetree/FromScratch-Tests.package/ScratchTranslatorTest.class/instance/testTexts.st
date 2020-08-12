test
testTexts
	| t |
	t := self newTranslator.
	self assert: t texts isDictionary.
	self assert: t texts isEmpty	
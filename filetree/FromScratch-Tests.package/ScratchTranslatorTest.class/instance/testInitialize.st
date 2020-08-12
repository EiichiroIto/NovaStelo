test
testInitialize
	| t |
	t := self newTranslator.
	self assert: t fonts isDictionary.
	self assert: t texts isDictionary
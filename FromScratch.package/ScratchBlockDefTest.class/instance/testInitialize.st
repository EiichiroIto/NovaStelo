test
testInitialize
	| sp |
	sp := self basicNewBlockDef.
	self deny: sp privBlockSpecs isDictionary.
	self deny: sp privBlockColors isDictionary.
	sp initialize.
	self assert: sp privBlockSpecs isDictionary.
	self assert: sp privBlockColors isDictionary
test
testPrivBlocks
	| sp |
	sp := self newBlockDef.
	self assert: sp privBlocks isDictionary
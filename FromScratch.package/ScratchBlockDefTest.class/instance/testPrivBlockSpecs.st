test
testPrivBlockSpecs
	| sp |
	sp := self newBlockDef.
	self assert: sp privBlockSpecs isDictionary
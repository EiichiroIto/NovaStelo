test
testUnknownCategoryColor
	| sp |
	sp := self newBlockDef.
	self assert: sp unknownCategoryColor equals: (Color h: 0 s: 0.81 v: 0.83)
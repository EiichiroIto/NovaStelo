test
testBlockColorFor
	| sp |
	sp := self newBlockDef.
	sp addCategory: 'operators' color: Color blue.
	sp addCategory: 'control' color: Color yellow.
	self assert: (sp blockColorFor: 'operators') equals: Color blue.
	self assert: (sp blockColorFor: 'basic') equals: sp unknownCategoryColor.
	self assert: (sp blockColorFor: 'control') equals: Color yellow
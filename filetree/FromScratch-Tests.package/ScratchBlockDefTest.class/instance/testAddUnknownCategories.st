test
testAddUnknownCategories
	| sp |
	sp := self newBlockDef.
	sp addSpec: #- category: 'basic'.
	sp addSpec: #(a b) category: 'operators'.
	sp addSpec: #(c d) category: 'basic'.
	sp addCategory: 'basic' color: Color red.
	self assertCollection: sp blockCategories equals: #(basic).
	sp addUnknownCategories.
	self assertCollection: sp blockCategories equals: #(basic operators).
	self assert: (sp blockColorFor: 'basic') equals: Color red.
	self assert: (sp blockColorFor: 'operators') equals: sp unknownCategoryColor
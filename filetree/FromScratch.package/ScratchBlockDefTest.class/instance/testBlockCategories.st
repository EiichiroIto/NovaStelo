test
testBlockCategories
	| sp ret |
	sp := self newBlockDef.
	sp addSpec: #- category: 'basic'.
	sp addSpec: #(a b) category: 'operators'.
	sp addSpec: #(c d) category: 'basic'.
	ret := sp blockCategories.
	self assertCollection: ret equals: #('basic' 'operators')
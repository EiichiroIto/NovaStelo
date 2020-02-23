test
testBlockCategories
	| sp ret |
	sp := self newBlockDef.
	sp addCategory: 'basic' color: Color red.
	sp addCategory: 'operators' color: Color blue.
	ret := sp blockCategories.
	self assertCollection: ret equals: #('basic' 'operators')
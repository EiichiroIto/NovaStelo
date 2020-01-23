test
testAddSpecCategory
	| sp ret |
	sp := self newBlockDef.
	sp addSpec: #- category: 'basic'.
	sp addSpec: #(a b) category: 'operators'.
	sp addSpec: #(c d) category: 'basic'.
	ret := sp privBlocks at: 'basic'.
	self assert: ret isCollection.
	self assert: ret size equals: 2.
	self assert: ret first equals: #-.
	self assertCollection: ret second equals: #(c d).
	ret := sp privBlocks at: 'operators'.
	self assert: ret isCollection.
	self assert: ret size equals: 1.
	self assertCollection: ret first equals: #(a b)
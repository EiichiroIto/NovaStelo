test
testBlockAttachPoints
	| b1 b2 b3 s |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	s := OrderedCollection new.
	b1 blockAttachPoints: s.
	self assert: s size equals: 4.
	self assert: (s allSatisfy: [:each | each isKindOf: Association]).
	self assert: (s allSatisfy: [:each | each key isPoint]).
	self assert: (s allSatisfy: [:each | each value isBlockMorph]).
	self assert: s first key equals: b1 topLeft.
	self assert: s second key equals: b1 bottomLeft.
	self assert: s third key equals: b2 topLeft.
	self assert: s fourth key equals: b3 topLeft
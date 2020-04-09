test
testSubBlockTupleFor
	| i ret |
	i := self newImporter.
	ret := i subBlockTupleFor: 'abc'.
	self assertCollection: ret equals: #(SubHatMorph abc)
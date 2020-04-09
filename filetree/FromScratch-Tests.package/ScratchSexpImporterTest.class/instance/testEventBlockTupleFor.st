test
testEventBlockTupleFor
	| i ret |
	i := self newImporter.
	ret := i eventBlockTupleFor: 'abc'.
	self assertCollection: ret equals: #(EventHatMorph abc)
test
testGetVarTupleFrom
	| i ret |
	i := self newImporter.
	ret := i getVarTupleFrom: #(getVar abc).
	self assertCollection: ret equals: #(readVariable abc)
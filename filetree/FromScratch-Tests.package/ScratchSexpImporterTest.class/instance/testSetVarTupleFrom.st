test
testSetVarTupleFrom
	| i ret |
	i := self newImporter.
	ret := i setVarTupleFrom: #(#setVar:to: life 1).
	self
		assertCollection: ret
		equals: #(changeVariable life #setVar:to: 1).
	ret := i setVarTupleFrom: #(#changeVar:by: energy -0.1).
	self
		assertCollection: ret
		equals: #(changeVariable energy #changeVar:by: -0.1)
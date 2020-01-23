test
testPrivLabelId
	| b |
	b := self newGenerator.
	self assert: b privLabelId class equals: BaseId.
	self assert: b privLabelId size equals: 0.
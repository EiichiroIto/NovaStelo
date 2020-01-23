test
testReturnValue
	| b r |
	b := self newGenerator.
	b returnValue.
	b address: 5.
	r := b code.
	self assertCollection: r equals: #(returnValue stop).
test
testDefaultElement
	| a |
	a := self newArray.
	self assert: a defaultElement isString.
	self assert: a defaultElement isEmpty
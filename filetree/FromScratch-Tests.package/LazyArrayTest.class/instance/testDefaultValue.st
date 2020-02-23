test
testDefaultValue
	| a |
	a := self newArray: #FloatArray.
	self assert: a defaultValue equals: 0.
	a defaultValue: 12.
	self assert: a defaultValue equals: 12.
	self should: [ a defaultValue: 10 ] raise: Error.
	a := self newArray: #StringArray.
	self assert: a defaultValue equals: ''
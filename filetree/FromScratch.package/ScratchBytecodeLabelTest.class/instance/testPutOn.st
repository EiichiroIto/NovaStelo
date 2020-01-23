test
testPutOn
	| c stream |
	c := self newLabel: 1.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assert: stream contents isEmpty.
test
testPutOn
	| c stream |
	c := self newBytecode.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assert: stream contents isEmpty.
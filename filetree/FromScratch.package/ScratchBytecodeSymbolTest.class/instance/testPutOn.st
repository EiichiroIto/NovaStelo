test
testPutOn
	| c stream |
	c := self newSymbol: #abc.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(abc).
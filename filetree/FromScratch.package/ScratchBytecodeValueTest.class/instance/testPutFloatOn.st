test
testPutFloatOn
	| c stream |
	c := self newValue: 123.0.
	stream := WriteStream on: Array new.
	c putFloatOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushFloat 16r00 16r00 16rF6 16r42).
	c := self newValue: -5.3.
	stream := WriteStream on: Array new.
	c putFloatOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushFloat 16r9A 16r99 16rA9 16rC0)
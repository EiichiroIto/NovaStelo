test
testPutOn
	| c stream |
	c := self newValue: 0.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(push0).
	c := self newValue: 1.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(push1).
	c := self newValue: 2.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(pushShort 2 0).
	c := self newValue: 123.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(pushShort 123 0).
	c := self newValue: -2.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushShort 16rFE 16rFF).
	c := self newValue: 123.0.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushFloat 16r00 16r00 16rF6 16r42).
	c := self newValue: -5.3.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushFloat 16r9A 16r99 16rA9 16rC0)
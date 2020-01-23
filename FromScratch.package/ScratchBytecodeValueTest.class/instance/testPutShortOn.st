test
testPutShortOn
	| c stream |
	c := self newValue: 123.
	stream := WriteStream on: Array new.
	c putShortOn: stream.
	self assertCollection: stream contents equals: #(pushShort 123 0).
	c := self newValue: -123.
	stream := WriteStream on: Array new.
	c putShortOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushShort 16r85 16rFF)
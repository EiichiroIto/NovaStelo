test
testPutShortOn
	| c stream |
	c := ScratchBytecode basicNew.
	stream := WriteStream on: Array new.
	c putShort: 123 on: stream.
	self assertCollection: stream contents equals: #(pushShort 123 0).
	c := ScratchBytecode basicNew.
	stream := WriteStream on: Array new.
	c putShort: -123 on: stream.
	self
		assertCollection: stream contents
		equals: #(pushShort 16r85 16rFF)
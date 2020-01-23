test
testPrivStream
	| e s |
	e := self newExporter.
	self assert: e privStream isNil.
	s := WriteStream on: ''.
	e privStream: s.
	self assert: e privStream equals: s.
test
testWriteScript
	| ex sc |
	sc := self newScript.
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeScript: sc.
	self
		assert: ex privStream contents
		equals: '(for test (a "b c")' , String lf , '())' , String lf
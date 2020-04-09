test
testWriteVarNames
	| ex sc |
	sc := self newScript.
	sc objName: 'test'.
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeVarNames: sc.
	self
		assert: ex privStream contents
		equals: '(var "a") (var "b c") (list "d") (list "e f")'
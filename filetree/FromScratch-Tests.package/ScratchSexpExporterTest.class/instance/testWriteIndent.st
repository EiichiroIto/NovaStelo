test
testWriteIndent
	| ex |
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeIndent.
	self assert: ex privStream contents equals: String lf, '   '
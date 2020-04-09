test
testWriteScriptSeparator
	| ex |
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeScriptSeparator.
	self assert: ex privStream contents equals: String lf, '  '
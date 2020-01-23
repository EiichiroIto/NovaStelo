test
testWriteFooter
	| ex |
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeFooter: nil.
	self assert: ex privStream contents equals: '))'
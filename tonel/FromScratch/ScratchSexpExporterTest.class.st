"
A ScratchSexpExporterTest is a test class for testing the behavior of ScratchSexpExporter
"
Class {
	#name : #ScratchSexpExporterTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchSexpExporterTest >> appName [
	^ 'abc'
]

{ #category : #private }
ScratchSexpExporterTest >> newExporter [
	^ ScratchSexpExporter appName: self appName
]

{ #category : #private }
ScratchSexpExporterTest >> newProject [
	^ ScratchProject new
]

{ #category : #private }
ScratchSexpExporterTest >> newScript [
	^ ScTestScript new
]

{ #category : #test }
ScratchSexpExporterTest >> testAppName [
	| ex |
	ex := self newExporter.
	self assert: ex appName equals: self appName.
	ex appName: 'def'.
	self assert: ex appName equals: 'def'
]

{ #category : #test }
ScratchSexpExporterTest >> testWriteFooter [
	| ex |
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeFooter: nil.
	self assert: ex privStream contents equals: '))'
]

{ #category : #test }
ScratchSexpExporterTest >> testWriteHeader [
	| ex proj |
	proj := self newProject.
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeHeader: proj.
	self assert: ex privStream contents equals: '(abc ()', String lf, '('
]

{ #category : #test }
ScratchSexpExporterTest >> testWriteScript [
	| ex sc |
	sc := self newScript.
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeScript: sc.
	self
		assert: ex privStream contents
		equals: '(for test (a "b c")' , String lf , '())' , String lf
]

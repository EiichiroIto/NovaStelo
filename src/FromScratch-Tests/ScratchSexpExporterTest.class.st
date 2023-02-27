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
	self assert: ex stream contents equals: '))'
]

{ #category : #test }
ScratchSexpExporterTest >> testWriteHeader [
	| ex proj |
	proj := self newProject.
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeHeader: proj.
	self assert: ex stream contents equals: '(abc ()', String lf, ' ('
]

{ #category : #test }
ScratchSexpExporterTest >> testWriteIndent [
	| ex |
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeIndent.
	self assert: ex stream contents equals: String lf, '   '
]

{ #category : #test }
ScratchSexpExporterTest >> testWriteScript [
	| ex sc |
	sc := self newScript.
	sc objName: 'test'.
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeScript: sc.
	self
		assert: ex stream contents
		equals:
			'(for test ((var "a") (var "b c") (list "d") (list "e f"))' , String lf
				, '   ())'
]

{ #category : #test }
ScratchSexpExporterTest >> testWriteScriptNames [
	| ex proj |
	proj := self newProject.
	proj
		addScript:
			(self newScript
				objName: 'a';
				yourself);
		addScript:
			(self newScript
				objName: 'b';
				yourself).
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeScriptNames: proj.
	self assert: ex stream contents equals: '(a b)'
]

{ #category : #test }
ScratchSexpExporterTest >> testWriteScriptSeparator [
	| ex |
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeScriptSeparator.
	self assert: ex stream contents equals: String lf, '  '
]

{ #category : #test }
ScratchSexpExporterTest >> testWriteVarNames [
	| ex sc |
	sc := self newScript.
	sc objName: 'test'.
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeVarNames: sc.
	self
		assert: ex stream contents
		equals: '(var "a") (var "b c") (list "d") (list "e f")'
]

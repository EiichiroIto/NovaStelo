"
A SExporterTest is a test class for testing the behavior of SExporter
"
Class {
	#name : 'ScratchExporterTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
ScratchExporterTest >> newExporter [
	^ ScratchExporter new
]

{ #category : 'test' }
ScratchExporterTest >> testPrivStream [
	| e s |
	e := self newExporter.
	self assert: e stream isNil.
	s := WriteStream on: ''.
	e privStream: s.
	self assert: e stream equals: s.
]

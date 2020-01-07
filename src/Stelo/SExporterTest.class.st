"
A SExporterTest is a test class for testing the behavior of SExporter
"
Class {
	#name : #SExporterTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-private' }
SExporterTest >> testEventIdFor [
	| e d |
	e := SExporter new.
	d := Dictionary new.
	d at: #a put: 1.
	d at: #b put: 2.
	e privEvents: d.
	self assert: (e eventIdFor: #a) equals: 1.
	self assert: (e eventIdFor: #b) equals: 2.
]

{ #category : #'tests-private' }
SExporterTest >> testPrivEvents [
	| e d |
	e := SExporter new.
	self assert: e privEvents isNil.
	d := Dictionary new.
	e privEvents: d.
	self assert: e privEvents equals: d.
	
]

{ #category : #'tests-private' }
SExporterTest >> testPrivStream [
	| e s |
	e := SExporter new.
	self assert: e privStream isNil.
	s := WriteStream on: ''.
	e privStream: s.
	self assert: e privStream equals: s.
]

Class {
	#name : #ScratchExporter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'FromScratch-Converter'
}

{ #category : #accessing }
ScratchExporter >> exportFrom: anApplication [
	| project |
	project := anApplication project.
	stream := WriteStream on: ''.
	self writeHeader: project.
	self writeScripts: project scripts.
	self writeFooter: project.
	^ stream contents
]

{ #category : #private }
ScratchExporter >> privStream [
	^ stream
]

{ #category : #private }
ScratchExporter >> privStream: aStream [
	stream := aStream.
]

{ #category : #private }
ScratchExporter >> writeFooter: aProject [
	self subclassResponsibility
]

{ #category : #private }
ScratchExporter >> writeHeader: aProject [
	self subclassResponsibility
]

{ #category : #private }
ScratchExporter >> writeScript: aScript [
	self subclassResponsibility.
]

{ #category : #private }
ScratchExporter >> writeScripts: aCollection [
	aCollection do: [ :each | self writeScript: each ].
]

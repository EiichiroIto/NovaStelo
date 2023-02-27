Class {
	#name : #ScratchExporter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'FromScratch-Converter'
}

{ #category : #accessing }
ScratchExporter >> exportFrom: anApplication isBinary: aBoolean [
	| project |
	project := anApplication project.
	stream := WriteStream
		on:
			(aBoolean
				ifTrue: [ ByteArray new ]
				ifFalse: [ '' ]).
	self writeHeader: project.
	self writeScripts: project scripts.
	self writeFooter: project.
	^ stream contents
]

{ #category : #private }
ScratchExporter >> privStream: aStream [
	stream := aStream.
]

{ #category : #private }
ScratchExporter >> stream [
	^ stream
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
ScratchExporter >> writeScriptSeparator [
	"do nothing"
]

{ #category : #private }
ScratchExporter >> writeScripts: aCollection [
	aCollection
		do: [ :each | self writeScript: each ]
		separatedBy: [ self writeScriptSeparator ]
]

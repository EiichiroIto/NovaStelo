"
A ScratchProjectReadWriterTest is a test class for testing the behavior of ScratchProjectReadWriter
"
Class {
	#name : #ScratchProjectReadWriterTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchProjectReadWriterTest >> newObj [

	^ ScratchProjectReadWriter new
]

{ #category : #test }
ScratchProjectReadWriterTest >> testFileVersion [

	| obj |
	obj := self newObj.
	self assert: obj fileVersion isNil.
	obj fileVersion: 123.
	self assert: obj fileVersion equals: 123
]

{ #category : #test }
ScratchProjectReadWriterTest >> testFileVersionString [

	| obj |
	obj := self newObj.
	obj fileVersion: 5.
	obj fileVersionTag: 'Test'.
	self assert: obj fileVersionString equals: 'Test05'
]

{ #category : #test }
ScratchProjectReadWriterTest >> testFileVersionTag [

	| obj |
	obj := self newObj.
	self assert: obj fileVersionTag isNil.
	obj fileVersionTag: 'Test'.
	self assert: obj fileVersionTag equals: 'Test'
]

{ #category : #test }
ScratchProjectReadWriterTest >> testObjStream [

	| obj x |
	obj := self newObj.
	self assert: obj objStream isNil.
	x := ObjStream new.
	obj objStream: x.
	self assert: obj objStream identicalTo: x
]

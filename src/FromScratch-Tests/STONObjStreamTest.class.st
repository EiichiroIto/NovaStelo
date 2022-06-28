"
A STONObjStreamTest is a test class for testing the behavior of STONObjStream
"
Class {
	#name : #STONObjStreamTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
STONObjStreamTest >> newObjStream [
	^ STONObjStream new
]

{ #category : #test }
STONObjStreamTest >> testReadAndStore [
	| obj s x data r |
	obj := self newObjStream.
	data := 'アクセスランキング'.
	s := WriteStream on: ByteArray new.
	obj storeObj: data on: s.
	x := s contents.
	s := ReadStream on: x.
	r := obj readObjFrom: s showProgress: false.
	self assert: r equals: data
]

{ #category : #test }
STONObjStreamTest >> testReadObjFromShowProgress [
	| obj s r |
	obj := self newObjStream.
	s := ReadStream on: '123' asByteArray.
	r := obj readObjFrom: s showProgress: false.
	self assert: r equals: 123.
	s := ReadStream on: '''abc''' asByteArray.
	r := obj readObjFrom: s showProgress: false.
	self assert: r equals: 'abc'
]

{ #category : #test }
STONObjStreamTest >> testStoreObjOn [
	| obj s |
	obj := self newObjStream.
	s := WriteStream on: ByteArray new.
	obj storeObj: 'abc' on: s.
	self assert: s contents equals: '''abc''' asByteArray.
	s := WriteStream on: ByteArray new.
	obj storeObj: 123 on: s.
	self assert: s contents equals: '123' asByteArray
]

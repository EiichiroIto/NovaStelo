"
A ScratchBlockSeparatorTest is a test class for testing the behavior of ScratchBlockSeparator
"
Class {
	#name : #ScratchBlockSeparatorTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchBlockSeparatorTest >> newObj [

	^ ScratchBlockSeparator new
]

{ #category : #test }
ScratchBlockSeparatorTest >> testIsSeparator [

	self assert: self newObj isSeparator
]

{ #category : #test }
ScratchBlockSeparatorTest >> testPrintOn [

	| obj s |
	obj := self newObj.
	s := WriteStream on: String new.
	obj printOn: s.
	self assert: s contents equals: 'ScratchBlockSeparator'
]

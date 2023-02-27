"
A StartHatMorphTest is a test class for testing the behavior of StartHatMorph
"
Class {
	#name : #StartHatMorphTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
StartHatMorphTest >> newMorph [

	^ StartHatMorph new
]

{ #category : #test }
StartHatMorphTest >> testAsBlockTuple [

	| obj |
	obj := self newMorph.
	obj selector: #abc.
	self assertCollection: obj asBlockTuple equals: #( abc )
]

{ #category : #test }
StartHatMorphTest >> testCommandSpec [

	| obj |
	obj := self newMorph.
	self assert: obj commandSpec isString.
	obj commandSpec: 'abc'.
	self assert: obj commandSpec equals: 'abc'
]

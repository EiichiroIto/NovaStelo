"
A SetterBlockMorphTest is a test class for testing the behavior of SetterBlockMorph
"
Class {
	#name : #SetterBlockMorphTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
SetterBlockMorphTest >> newBlock [

	^ SetterBlockMorph new
]

{ #category : #test }
SetterBlockMorphTest >> testIsSetterBlock [

	self assert: self newBlock isSetterBlock
]

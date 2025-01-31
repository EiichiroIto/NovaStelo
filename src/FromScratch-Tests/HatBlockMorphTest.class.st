"
A HatBlockMorphTest is a test class for testing the behavior of HatBlockMorph
"
Class {
	#name : 'HatBlockMorphTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
HatBlockMorphTest >> newMorph [

	^ HatBlockMorph new
]

{ #category : 'test' }
HatBlockMorphTest >> testArgPermutation [

	self newMorph argPermutation: #( a b c )
]

{ #category : 'test' }
HatBlockMorphTest >> testDefaultArgs [

	self newMorph defaultArgs: #( a b c )
]

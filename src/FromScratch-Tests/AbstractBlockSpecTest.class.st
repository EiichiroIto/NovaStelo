"
An AbstractBlockSpecTest is a test class for testing the behavior of AbstractBlockSpec
"
Class {
	#name : #AbstractBlockSpecTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #test }
AbstractBlockSpecTest >> testIsBlockMorph [

	self deny: AbstractBlockSpec new isBlockMorph
]

{ #category : #test }
AbstractBlockSpecTest >> testIsBlockSpec [

	self deny: AbstractBlockSpec new isBlockSpec
]

{ #category : #test }
AbstractBlockSpecTest >> testIsCategory [

	self deny: AbstractBlockSpec new isCategory
]

{ #category : #test }
AbstractBlockSpecTest >> testIsChoiceArg [

	self deny: AbstractBlockSpec new isChoiceArg
]

{ #category : #test }
AbstractBlockSpecTest >> testIsSeparator [

	self deny: AbstractBlockSpec new isSeparator
]

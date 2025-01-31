"
An AlgoritStepperMorphTest is a test class for testing the behavior of AlgoritStepperMorph
"
Class {
	#name : 'ScratchStepperMorphTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
ScratchStepperMorphTest >> newMorph [
	^ ScratchStepperMorph new
]

{ #category : 'test' }
ScratchStepperMorphTest >> testDefaultStepTime [
	self assert: self newMorph defaultStepTime equals: 100
]

{ #category : 'test' }
ScratchStepperMorphTest >> testStepTime [
	| s |
	s := self newMorph.
	self assert: s stepTime equals: s defaultStepTime.
	s stepTime: 123.
	self assert: s stepTime equals: 123
]

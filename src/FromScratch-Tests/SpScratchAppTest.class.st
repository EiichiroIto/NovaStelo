"
A SpScratchAppTest is a test class for testing the behavior of SpScratchApp
"
Class {
	#name : #SpScratchAppTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
SpScratchAppTest >> newApp [

	^ SpScratchApp new
]

{ #category : #test }
SpScratchAppTest >> testUseErrorCatcher [

	| tmp |
	tmp := SpScratchApp useErrorCatcher.
	[ 
	SpScratchApp useErrorCatcher: true.
	self assert: SpScratchApp useErrorCatcher.
	SpScratchApp useErrorCatcher: false.
	self deny: SpScratchApp useErrorCatcher ] ensure: [ 
		SpScratchApp useErrorCatcher: tmp ]
]

{ #category : #test }
SpScratchAppTest >> testUseSingleClick [

	| tmp |
	tmp := SpScratchApp useSingleClick.
	[ 
	SpScratchApp useSingleClick: true.
	self assert: SpScratchApp useSingleClick.
	SpScratchApp useSingleClick: false.
	self deny: SpScratchApp useSingleClick ] ensure: [ 
		SpScratchApp useSingleClick: tmp ]
]

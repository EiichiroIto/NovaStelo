"
A ScratchScriptTest is a test class for testing the behavior of ScratchScript
"
Class {
	#name : #ScratchScriptTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchScriptTest >> newScript [
	^ ScratchScript new
]

{ #category : #test }
ScratchScriptTest >> testPrivBlockDef [
	| script |
	script := self newScript.
	self assert: script privBlockDef class equals: ScratchBlockDef
]

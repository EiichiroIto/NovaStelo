"
A SteloProcessTest is a test class for testing the behavior of SteloProcess
"
Class {
	#name : #ScratchBaseProcessTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchBaseProcessTest >> newProcess [
	^ ScratchBaseProcess new
]

{ #category : #test }
ScratchBaseProcessTest >> testProgram [
	| pr |
	pr := self newProcess.
	self assert: pr program isNil.
	pr program: 123.
	self assert: pr program equals: 123.
]

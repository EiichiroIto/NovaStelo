"
A SteloProcessTest is a test class for testing the behavior of SteloProcess
"
Class {
	#name : 'ScratchNativeProcessTest',
	#superclass : 'TestCase',
	#category : 'Microworld-Tests',
	#package : 'Microworld',
	#tag : 'Tests'
}

{ #category : 'private' }
ScratchNativeProcessTest >> newProcess [
	^ ScratchNativeProcess new
]

{ #category : 'test' }
ScratchNativeProcessTest >> testProgram [
	| pr |
	pr := self newProcess.
	self assert: pr program isNil.
	pr program: 123.
	self assert: pr program equals: 123.
]

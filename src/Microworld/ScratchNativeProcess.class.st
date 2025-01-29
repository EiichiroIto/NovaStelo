Class {
	#name : 'ScratchNativeProcess',
	#superclass : 'Object',
	#instVars : [
		'program'
	],
	#category : 'Microworld-Process',
	#package : 'Microworld',
	#tag : 'Process'
}

{ #category : 'testing' }
ScratchNativeProcess >> isRunning [
	self subclassResponsibility.
]

{ #category : 'api' }
ScratchNativeProcess >> loop [
	self subclassResponsibility.
]

{ #category : 'accessing' }
ScratchNativeProcess >> program [
	^ program
]

{ #category : 'accessing' }
ScratchNativeProcess >> program: aProgram [
	program := aProgram.
]

{ #category : 'api' }
ScratchNativeProcess >> single [
	self subclassResponsibility.
]

{ #category : 'api' }
ScratchNativeProcess >> startup [
	self subclassResponsibility.
]

{ #category : 'api' }
ScratchNativeProcess >> step [
	self subclassResponsibility.
]

{ #category : 'api' }
ScratchNativeProcess >> stop [
	self subclassResponsibility.
]

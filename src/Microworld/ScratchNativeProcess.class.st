Class {
	#name : #ScratchNativeProcess,
	#superclass : #Object,
	#instVars : [
		'program'
	],
	#category : #'Microworld-Process'
}

{ #category : #testing }
ScratchNativeProcess >> isRunning [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchNativeProcess >> loop [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchNativeProcess >> program [
	^ program
]

{ #category : #accessing }
ScratchNativeProcess >> program: aProgram [
	program := aProgram.
]

{ #category : #accessing }
ScratchNativeProcess >> single [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchNativeProcess >> startup [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchNativeProcess >> step [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchNativeProcess >> stop [
	self subclassResponsibility.
]

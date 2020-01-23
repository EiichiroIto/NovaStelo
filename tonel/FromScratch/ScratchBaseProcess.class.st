Class {
	#name : #ScratchBaseProcess,
	#superclass : #Object,
	#instVars : [
		'program'
	],
	#category : #'FromScratch-Process'
}

{ #category : #testing }
ScratchBaseProcess >> isRunning [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchBaseProcess >> loop [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchBaseProcess >> program [
	^ program
]

{ #category : #accessing }
ScratchBaseProcess >> program: aProgram [
	program := aProgram.
]

{ #category : #accessing }
ScratchBaseProcess >> single [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchBaseProcess >> startup [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchBaseProcess >> step [
	self subclassResponsibility.
]

{ #category : #accessing }
ScratchBaseProcess >> stop [
	self subclassResponsibility.
]

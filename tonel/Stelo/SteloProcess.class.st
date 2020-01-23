Class {
	#name : #SteloProcess,
	#superclass : #ScratchBaseProcess,
	#instVars : [
		'sworld'
	],
	#category : #'Stelo-Process'
}

{ #category : #'instance creation' }
SteloProcess class >> sworld: aSWorld [
	^ self basicNew
		initialize;
		privSWorld: aSWorld;
		yourself
]

{ #category : #private }
SteloProcess >> privSWorld [
	^ sworld
]

{ #category : #private }
SteloProcess >> privSWorld: anObject [
	sworld := anObject.
]

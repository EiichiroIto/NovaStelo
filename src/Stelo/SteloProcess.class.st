Class {
	#name : #SteloProcess,
	#superclass : #ScratchNativeProcess,
	#instVars : [
		'sworld'
	],
	#category : #'Stelo-Process'
}

{ #category : #'instance creation' }
SteloProcess class >> sworld: aSWorld [
	^ self basicNew
		initialize;
		sworld: aSWorld;
		yourself
]

{ #category : #accessing }
SteloProcess >> sworld [
	^ sworld
]

{ #category : #accessing }
SteloProcess >> sworld: anObject [
	sworld := anObject.
]

Class {
	#name : #SVarArgMorph,
	#superclass : #Object,
	#instVars : [
		'choice'
	],
	#category : #'Stelo-Tests'
}

{ #category : #accessing }
SVarArgMorph >> choice [

	^ choice
]

{ #category : #accessing }
SVarArgMorph >> choice: anObject [

	choice := anObject
]

{ #category : #accessing }
SVarArgMorph >> variable [

	^ choice
]

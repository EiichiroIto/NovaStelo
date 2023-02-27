Class {
	#name : #STestScript,
	#superclass : #Object,
	#category : #'Stelo-Tests'
}

{ #category : #accessing }
STestScript >> varNoFor: aString [

	aString = 'a' ifTrue: [ ^ 5 ].
	aString = 'b' ifTrue: [ ^ 3 ].
	self error
]

Class {
	#name : #SBreedId,
	#superclass : #BaseId,
	#category : #'Stelo-Model'
}

{ #category : #accessing }
SBreedId class >> observerBreedNo [
	^ 1
]

{ #category : #accessing }
SBreedId class >> patchBreedNo [
	^ 2
]

{ #category : #private }
SBreedId class >> reservedNo [
	^ 2
]

{ #category : #accessing }
SBreedId class >> turtleBreedNo [
	^ 3
]

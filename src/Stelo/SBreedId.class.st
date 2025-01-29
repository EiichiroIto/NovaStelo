Class {
	#name : 'SBreedId',
	#superclass : 'BaseId',
	#category : 'Stelo-Model',
	#package : 'Stelo',
	#tag : 'Model'
}

{ #category : 'accessing' }
SBreedId class >> observerBreedNo [
	^ 1
]

{ #category : 'accessing' }
SBreedId class >> patchesBreedNo [
	^ 2
]

{ #category : 'private' }
SBreedId class >> reservedNo [
	^ 2
]

{ #category : 'accessing' }
SBreedId class >> turtlesBreedNo [
	^ 3
]

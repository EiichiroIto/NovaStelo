"
A SBreedIdTest is a test class for testing the behavior of SBreedId
"
Class {
	#name : #SBreedIdTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-accessing' }
SBreedIdTest >> testObserverBreedNo [
	self assert: SBreedId observerBreedNo equals: 1.
]

{ #category : #'tests-accessing' }
SBreedIdTest >> testPatchesBreedNo [
	self assert: SBreedId patchesBreedNo equals: 2.
]

{ #category : #'tests-accessing' }
SBreedIdTest >> testReservedNo [
	self assert: SBreedId reservedNo equals: SBreedId patchesBreedNo.
]

{ #category : #'tests-accessing' }
SBreedIdTest >> testTurtlesBreedNo [
	self assert: SBreedId turtlesBreedNo equals: 3.
]

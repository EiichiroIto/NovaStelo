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
SBreedIdTest >> testPatchBreedNo [
	self assert: SBreedId patchBreedNo equals: 2.
]

{ #category : #'tests-accessing' }
SBreedIdTest >> testReservedNo [
	self assert: SBreedId reservedNo equals: SBreedId patchBreedNo.
]

{ #category : #'tests-accessing' }
SBreedIdTest >> testTurtleBreedNo [
	self assert: SBreedId turtleBreedNo equals: 3.
]

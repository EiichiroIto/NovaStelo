"
A SObserverTest is a test class for testing the behavior of SObserver
"
Class {
	#name : #SObserverTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SObserverTest >> newWorld [
	| w |
	w := SMicroWorld new.
	w addBreed: (SObserver new sworld: w).
	w addBreed: SPatches new.
	w newBreed.
	^ w
]

{ #category : #test }
SObserverTest >> testBreedNo [
	| o |
	o := SObserver new.
	self assert: o breedNo equals: SBreedId observerBreedNo.
	o breedNo: 123.
	self assert: o breedNo equals: SBreedId observerBreedNo.
]

{ #category : #test }
SObserverTest >> testClearTicks [
	| o |
	o := SObserver new.
	self assert: o ticks equals: 0.
	o incrementTicks.
	self assert: o ticks equals: 1.
	o incrementTicks.
	self assert: o ticks equals: 2.
	o clearTicks.
	self assert: o ticks equals: 0.
]

{ #category : #test }
SObserverTest >> testIncrementTicks [
	| o |
	o := SObserver new.
	self assert: o ticks equals: 0.
	o incrementTicks.
	self assert: o ticks equals: 1.
	o incrementTicks.
	self assert: o ticks equals: 2.
]

{ #category : #test }
SObserverTest >> testTicks [
	| o |
	o := SObserver new.
	self assert: o ticks equals: 0.
]

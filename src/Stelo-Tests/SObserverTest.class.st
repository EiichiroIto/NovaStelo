"
A SObserverTest is a test class for testing the behavior of SObserver
"
Class {
	#name : #SObserverTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SObserverTest >> newBreed [

	^ SObserver new
]

{ #category : #private }
SObserverTest >> newWorld [
	| w |
	w := SMicroWorld new.
	w addBreed: (SObserver new sworld: w).
	w addBreed: SPatches new.
	w addNewTurtle.
	^ w
]

{ #category : #test }
SObserverTest >> testAliveAt [

	| obj |
	obj := self newBreed.
	self assert: (obj aliveAt: 1).
	self deny: (obj aliveAt: 2).
	self deny: (obj aliveAt: 3)
]

{ #category : #test }
SObserverTest >> testBreedId [

	| o x |
	o := self newBreed.
	self assert: (o breedId isKindOf: SBreedId).
	x := SBreedId new.
	o breedId: x.
	self assert: o breedId identicalTo: x
]

{ #category : #test }
SObserverTest >> testBreedName [

	self assert: self newBreed breedName equals: 'Observer'
]

{ #category : #test }
SObserverTest >> testBreedNo [

	| o |
	o := self newBreed.
	self assert: o breedNo equals: SBreedId observerBreedNo.
	o breedNo: 123.
	self assert: o breedNo equals: SBreedId observerBreedNo
]

{ #category : #test }
SObserverTest >> testClearTicks [

	| o |
	o := self newBreed.
	self assert: o ticks equals: 0.
	o incrementTicks.
	self assert: o ticks equals: 1.
	o incrementTicks.
	self assert: o ticks equals: 2.
	o clearTicks.
	self assert: o ticks equals: 0
]

{ #category : #test }
SObserverTest >> testColors [

	self should: [ self newBreed colors ] raise: Error
]

{ #category : #test }
SObserverTest >> testIncrementTicks [

	| o |
	o := self newBreed.
	self assert: o ticks equals: 0.
	o incrementTicks.
	self assert: o ticks equals: 1.
	o incrementTicks.
	self assert: o ticks equals: 2
]

{ #category : #test }
SObserverTest >> testInitialize [

	| obj |
	obj := self newBreed.
	self assert: (obj breedId isKindOf: SBreedId).
	self assert: obj breedId size equals: 2.
	self assert: obj ticks equals: 0
]

{ #category : #test }
SObserverTest >> testLivingOnesDo [

	| obj count |
	obj := self newBreed.
	count := 0.
	obj livingOnesDo: [ :each | 
		self assert: each equals: 1.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : #test }
SObserverTest >> testNewTurtles [

	| obj t |
	obj := self newBreed.
	t := obj newTurtles.
	self assert: (t isKindOf: STurtles).
	self assert: t breedNo equals: 3.
	t := obj newTurtles.
	self assert: (t isKindOf: STurtles).
	self assert: t breedNo equals: 4
]

{ #category : #test }
SObserverTest >> testNewVarDef [

	self assert: (self newBreed newVarDef isKindOf: SObserverVarDef)
]

{ #category : #test }
SObserverTest >> testReset [

	| obj tmp |
	obj := self newBreed.
	tmp := obj varDef size.
	obj addVariable: 'abc'.
	obj addVariable: 'der'.
	self assert: obj varDef size equals: tmp + 2.
	obj reset.
	self assert: obj varDef size equals: tmp
]

{ #category : #test }
SObserverTest >> testSize [

	self assert: self newBreed size equals: 1
]

{ #category : #test }
SObserverTest >> testTicks [

	| o |
	o := self newBreed.
	self assert: o ticks equals: 0.
	o ticks: 123.
	self assert: o ticks equals: 123
]

{ #category : #test }
SObserverTest >> testVarAt [

	| obj v1 v2 |
	obj := self newBreed.
	v1 := obj addVariable: 'abc'.
	v2 := obj addVariable: 'der'.
	self assert: (obj var: v1 at: 1) equals: 0.
	self assert: (obj var: v2 at: 1) equals: 0.
	obj var: v1 at: 1 put: 123.
	obj var: v2 at: 1 put: 456.
	self assert: (obj var: v1 at: 1) equals: 123.
	self assert: (obj var: v2 at: 1) equals: 456.
	obj ticks: 789.
	self assert: (obj var: SObserverVarDef ticksVarNo at: 1) equals: 789
]

{ #category : #test }
SObserverTest >> testVarAtPut [

	| obj v1 v2 |
	obj := self newBreed.
	v1 := obj addVariable: 'abc'.
	v2 := obj addVariable: 'der'.
	self assert: (obj var: v1 at: 1) equals: 0.
	self assert: (obj var: v2 at: 1) equals: 0.
	obj var: v1 at: 1 put: 123.
	obj var: v2 at: 1 put: 456.
	self assert: (obj var: v1 at: 1) equals: 123.
	self assert: (obj var: v2 at: 1) equals: 456.
	self assert: obj ticks equals: 0.
	obj var: SObserverVarDef ticksVarNo at: 1 put: 789.
	self assert: obj ticks equals: 789
]

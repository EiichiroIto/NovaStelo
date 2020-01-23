"
A SDisplayTest is a test class for testing the behavior of SDisplay
"
Class {
	#name : #SDisplayTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SDisplayTest >> newDisplay [
	^ SDisplay sworld: self newWorld
]

{ #category : #private }
SDisplayTest >> newWorld [
	| w |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	w addBreed: SPatches new.
	^ w
]

{ #category : #test }
SDisplayTest >> testCell [
	| d |
	d := self newDisplay.
	self assert: d cell isNil.
	d cell: 1 @ 2.
	self assert: d cell equals: 1 @ 2.
	d cell: 3 @ 4.
	self assert: d cell equals: 3 @ 4
]

{ #category : #test }
SDisplayTest >> testDefaultExtent [
	| d |
	d := self newDisplay.
	self assert: d defaultExtent isPoint
]

{ #category : #test }
SDisplayTest >> testDoDoubleClickAt [
	| d x |
	d := self newDisplay.
	d
		cell: 1 @ 1;
		offset: 0 @ 0;
		modelExtent: 100 @ 100;
		whenDoubleClickDo: [ :p | x := p ].
	d doDoubleClickAt: 0 @ 0.
	self assert: x equals: -50 @ 49
]

{ #category : #test }
SDisplayTest >> testExtent [
	| d |
	d := self newDisplay.
	d updateCache.
	self deny: d forceModelChanged.
	d extent: 100 @ 100.
	self assert: d extent equals: 100 @ 100.
	self assert: d forceModelChanged
]

{ #category : #test }
SDisplayTest >> testForceModelChanged [
	| d |
	d := self newDisplay.
	self assert: d forceModelChanged.
	d updateCache.
	self deny: d forceModelChanged
]

{ #category : #test }
SDisplayTest >> testInfo [
	| d |
	d := self newDisplay.
	self assert: d info isEmpty.
	d info: 'abc'.
	self assert: d info equals: 'abc'
]

{ #category : #test }
SDisplayTest >> testInitialize [
	| d |
	d := self newDisplay.
	self assert: d forceModelChanged.
	self assert: d info equals: ''.
	self assert: d stepTime equals: 1000
]

{ #category : #test }
SDisplayTest >> testModelBounds [
	| d |
	d := self newDisplay.
	self assert: d modelBounds isRectangle
]

{ #category : #test }
SDisplayTest >> testModelExtent [
	| d |
	d := self newDisplay.
	self assert: d modelExtent isNil.
	d modelExtent: 1 @ 2.
	self assert: d modelExtent equals: 1 @ 2
]

{ #category : #test }
SDisplayTest >> testOffset [
	| d |
	d := self newDisplay.
	self assert: d offset isNil.
	d offset: 1 @ 2.
	self assert: d offset equals: 1 @ 2.
	d offset: 3 @ 4.
	self assert: d offset equals: 3 @ 4
]

{ #category : #test }
SDisplayTest >> testPointOf [
	| d |
	d := self newDisplay.
	d
		cell: 1 @ 1;
		offset: 0 @ 0;
		modelExtent: 100 @ 100.
	self assert: (d pointOf: 0 @ 0) equals: -50 @ 49.
	self assert: (d pointOf: 99 @ 99) equals: 49 @ -50.
	self assert: (d pointOf: 0 @ 99) equals: -50 @ -50.
	self assert: (d pointOf: 99 @ 0) equals: 49 @ 49
]

{ #category : #test }
SDisplayTest >> testStep [
	| d x |
	d := self newDisplay.
	d step.
	x := 0.
	d whenStepsDo: [ x := 1 ].
	self assert: x equals: 0.
	d step.
	self assert: x equals: 1
]

{ #category : #test }
SDisplayTest >> testStepTime [
	| d |
	d := self newDisplay.
	self assert: d stepTime equals: 1000.
	d stepTime: 123.
	self assert: d stepTime equals: 123
]

{ #category : #test }
SDisplayTest >> testSworld [
	| d w |
	d := self newDisplay.
	self assert: (d sworld isKindOf: SWorld).
	w := self newWorld.
	d sworld: w.
	self assert: d sworld equals: w
]

{ #category : #test }
SDisplayTest >> testUpdateCache [
	| d |
	d := self newDisplay.
	self assert: d extent equals: 220 @ 220.
	self assert: d sworld extent equals: 100 @ 100.
	d updateCache.
	self assert: d cell equals: 2 @ 2.
	self assert: d offset equals: 10 @ 10.
	d extent: 150 @ 120.
	d updateCache.
	self assert: d cell equals: 1 @ 1.
	self assert: d offset equals: 25 @ 10.
]

{ #category : #test }
SDisplayTest >> testWantsSteps [
	| d |
	d := self newDisplay.
	self assert: d wantsSteps
]

{ #category : #test }
SDisplayTest >> testWhenDoubleClickDo [
	| d x |
	d := self newDisplay.
	self assert: d whenDoubleClickDo isNil.
	x := 0.
	d whenDoubleClickDo: [ x := 3 ].
	self assert: d whenDoubleClickDo isBlock
]

{ #category : #test }
SDisplayTest >> testWhenStepsDo [
	| d x |
	d := self newDisplay.
	self assert: d whenStepsDo isNil.
	x := 0.
	d whenStepsDo: [ x := 3 ].
	self assert: d whenStepsDo isBlock.
	d step.
	self assert: x equals: 3
]

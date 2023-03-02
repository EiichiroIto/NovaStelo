Class {
	#name : #SteloWorld,
	#superclass : #Object,
	#category : #'Stelo-Model'
}

{ #category : #api }
SteloWorld >> addBreed: aBreed [
	self subclassResponsibility.
]

{ #category : #api }
SteloWorld >> addVariable: aString var: vno breed: bno [
	self subclassResponsibility.
]

{ #category : #testing }
SteloWorld >> aliveBreed: bno at: id [
	| size |
	bno = SBreedId observerBreedNo
		ifTrue: [ ^ id = 1 ].
	size := self sizeOf: bno.
	(id between: 1 and: size)
		ifFalse: [ ^ false ].
	bno = SBreedId patchesBreedNo
		ifTrue: [ ^ true ].
	^ self flag: STurtlesVarDef aliveFlagNo breed: bno at: id
]

{ #category : #api }
SteloWorld >> clearBreed: anInteger [
	self subclassResponsibility.
]

{ #category : #accessing }
SteloWorld >> colors [
	self subclassResponsibility.
]

{ #category : #accessing }
SteloWorld >> countAliveOf: bno [
	self subclassResponsibility.
]

{ #category : #'thread ops' }
SteloWorld >> create: bid turtles: anInteger [
	self subclassResponsibility.
]

{ #category : #'thread ops' }
SteloWorld >> createPatch: anInteger [
	self subclassResponsibility.
]

{ #category : #api }
SteloWorld >> deleteBreed: aBreed [
	self subclassResponsibility
]

{ #category : #accessing }
SteloWorld >> extent [
	self subclassResponsibility.
]

{ #category : #'accessing variable' }
SteloWorld >> flag: anInteger breed: bid at: id [

	self subclassResponsibility
]

{ #category : #'accessing variable' }
SteloWorld >> flag: anInteger breed: bid at: id put: aNumber [

	self subclassResponsibility
]

{ #category : #testing }
SteloWorld >> isPluginWorld [
	^ false
]

{ #category : #'thread ops' }
SteloWorld >> kill: bid at: anInteger [
	(bid = SBreedId observerBreedNo or: [ bid = SBreedId patchesBreedNo ])
		ifTrue: [ ^ self ].
	self flag: STurtlesVarDef aliveFlagNo breed: bid at: anInteger put: false
]

{ #category : #'instance creation' }
SteloWorld >> newProcess [

	self subclassResponsibility
]

{ #category : #accessing }
SteloWorld >> patchIndexAtX: x y: y [
	self subclassResponsibility.
]

{ #category : #accessing }
SteloWorld >> plotList [
	self subclassResponsibility
]

{ #category : #api }
SteloWorld >> reset [
	self subclassResponsibility
]

{ #category : #api }
SteloWorld >> retrieveBreed: aBreed [

	self subclassResponsibility
]

{ #category : #accessing }
SteloWorld >> sizeOf: bno [
	self subclassResponsibility.
]

{ #category : #accessing }
SteloWorld >> ticks [
	^ self var: SObserverVarDef ticksVarNo breed: SBreedId observerBreedNo at: 1
]

{ #category : #'thread ops' }
SteloWorld >> turtle: bno at: pos exceptBreed: myBno index: myIndex [
	| list |
	list := self turtles: bno at: pos.
	bno = myBno
		ifTrue: [ list remove: myIndex ifAbsent: [  ] ].
	^ list isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ list anyOne ]
]

{ #category : #private }
SteloWorld >> turtles: bno at: pno [
	self subclassResponsibility
]

{ #category : #'accessing variable' }
SteloWorld >> var: vno breed: bno at: tno [
	self subclassResponsibility
]

{ #category : #'accessing variable' }
SteloWorld >> var: vno breed: bno at: tno put: value [
	self subclassResponsibility
]

{ #category : #'accessing variable' }
SteloWorld >> var: anInteger breed: bno list: id [
	self subclassResponsibility
]

{ #category : #'accessing variable' }
SteloWorld >> var: anInteger breed: bno list: id set: aCollection [
	self subclassResponsibility
]

{ #category : #accessing }
SteloWorld >> worldName [
	self subclassResponsibility
]

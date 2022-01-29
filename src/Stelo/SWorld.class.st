Class {
	#name : #SWorld,
	#superclass : #Object,
	#category : #'Stelo-Model'
}

{ #category : #accessing }
SWorld >> addBreed: aBreed [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> addList: aString var: vno breed: bno [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> addVariable: aString var: vno breed: bno [
	self subclassResponsibility.
]

{ #category : #testing }
SWorld >> aliveBreed: bno at: id [
	self subclassResponsibility
]

{ #category : #accessing }
SWorld >> backupBreeds: aCollection [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> clearBreed: anInteger [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> colors [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> countAliveOf: bno [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> create: bid turtles: anInteger [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> createPatch: anInteger [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> deleteBreed: aBreed [
	self subclassResponsibility
]

{ #category : #accessing }
SWorld >> extent [
	self subclassResponsibility.
]

{ #category : #command }
SWorld >> kill: bid at: anInteger [
	self subclassResponsibility
]

{ #category : #accessing }
SWorld >> newProcess [
	^ self processClass sworld: self
]

{ #category : #accessing }
SWorld >> patchIndexAtX: x y: y [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> plotList [
	self subclassResponsibility
]

{ #category : #private }
SWorld >> processClass [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> reset [
	self subclassResponsibility
]

{ #category : #accessing }
SWorld >> restoreBreeds: aCollection [
	self reset.
	aCollection do: [ :each | self addBreed: each ]
]

{ #category : #accessing }
SWorld >> setDefaultTurtle: bno at: aPoint [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> sizeOf: bno [
	self subclassResponsibility.
]

{ #category : #accessing }
SWorld >> ticks [
	^ self var: SObserverVarDef ticksVarNo breed: SBreedId observerBreedNo at: 1
]

{ #category : #command }
SWorld >> turtle: bno x: x y: y exceptBreed: myBno index: myIndex [
	self subclassResponsibility
]

{ #category : #accessing }
SWorld >> var: vno breed: bno at: tno [
	self subclassResponsibility
]

{ #category : #accessing }
SWorld >> var: vno breed: bno at: tno put: value [
	self subclassResponsibility
]

{ #category : #accessing }
SWorld >> var: anInteger breed: bno list: id [
	self subclassResponsibility
]

{ #category : #accessing }
SWorld >> var: anInteger breed: bno list: id set: aCollection [
	self subclassResponsibility
]

{ #category : #accessing }
SWorld >> worldName [
	self subclassResponsibility
]

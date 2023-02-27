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
	| size |
	bno = SBreedId observerBreedNo
		ifTrue: [ ^ id = 1 ].
	size := self sizeOf: bno.
	(id between: 1 and: size)
		ifFalse: [ ^ false ].
	bno = SBreedId patchBreedNo
		ifTrue: [ ^ true ].
	^ self flag: STurtleVarDef aliveFlagNo breed: bno at: id
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
SWorld >> flag: anInteger breed: bno at: id [
	| v b |
	v := self var: STurtleVarDef flagVarNo breed: bno at: id.
	b := 1 << anInteger.
	^ (v bitAnd: b) > 0
]

{ #category : #command }
SWorld >> flag: anInteger breed: bno at: id put: aBoolean [
	| v b |
	v := self var: STurtleVarDef flagVarNo breed: bno at: id.
	b := 1 << anInteger.
	v := aBoolean
		ifTrue: [ v bitOr: b ]
		ifFalse: [ v bitClear: b ].
	self var: STurtleVarDef flagVarNo breed: bno at: id put: v
]

{ #category : #testing }
SWorld >> isPluginWorld [
	^ false
]

{ #category : #command }
SWorld >> kill: bid at: anInteger [
	(bid = SBreedId observerBreedNo or: [ bid = SBreedId patchBreedNo ])
		ifTrue: [ ^ self ].
	self flag: STurtleVarDef aliveFlagNo breed: bid at: anInteger put: false
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
SWorld >> turtle: bno at: pos exceptBreed: myBno index: myIndex [
	| list |
	list := self turtles: bno at: pos.
	bno = myBno
		ifTrue: [ list remove: myIndex ifAbsent: [  ] ].
	^ list isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ list anyOne ]
]

{ #category : #private }
SWorld >> turtles: bno at: pno [
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

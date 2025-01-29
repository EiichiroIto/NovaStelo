Class {
	#name : 'SMicroWorld',
	#superclass : 'Object',
	#instVars : [
		'breeds',
		'raisedEvents',
		'plotList',
		'random'
	],
	#category : 'Stelo-Model',
	#package : 'Stelo',
	#tag : 'Model'
}

{ #category : 'samples' }
SMicroWorld class >> sample1 [
	"SMicroWorld sample1."

	| world d |
	world := SMicroWorld new.
	d := SDisplay sworld: world.
	world create: 10000 turtles: 2.
	"world turtlesDo: [ :ts :w :i | ts penDownAt: i put: true ].
	world turtlesDo: [ :ts :w :i | ts forward: 30 world: w at: i ]."
	d openInWorld.
	^ d.
]

{ #category : 'api' }
SMicroWorld >> addBreed: aBreed [
	| bno |
	bno := aBreed breedNo.
	breeds size < bno
		ifTrue: [ breeds := breeds forceTo: bno paddingWith: nil ].
	(breeds at: bno) ifNotNil: [ self error ].
	breeds at: bno put: aBreed
]

{ #category : 'api' }
SMicroWorld >> addNewTurtle [
	| breed |
	breed := self observer newTurtles.
	self addBreed: breed.
	^ breed
]

{ #category : 'thread ops' }
SMicroWorld >> aimHighPatchVar: vid breed: bid id: id [
	| x y heading |
	x := (breeds at: bid) xAt: id.
	y := (breeds at: bid) yAt: id.
	heading := (breeds at: bid) headingAt: id.
	^ self patches aimHighVarNo: vid atPoint: x @ y direction: heading
]

{ #category : 'testing' }
SMicroWorld >> aliveBreed: bno at: id [
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

{ #category : 'private' }
SMicroWorld >> breedOf: bid [
	^ breeds at: bid
]

{ #category : 'accessing' }
SMicroWorld >> breeds [
	^ breeds
]

{ #category : 'accessing' }
SMicroWorld >> breeds: anObject [

	breeds := anObject
]

{ #category : 'thread ops' }
SMicroWorld >> changeBreed: bid var: var by: aNumber [
	(self breedOf: bid) change: var by: aNumber
]

{ #category : 'api' }
SMicroWorld >> clearBreed: bno [
	(self breedOf: bno) clear.
]

{ #category : 'thread ops' }
SMicroWorld >> clearPlots [
	plotList add: ScratchPlot clearPlots
]

{ #category : 'api' }
SMicroWorld >> clearRaisedEvents [
	raisedEvents := Set new.
]

{ #category : 'api' }
SMicroWorld >> clearTicks [
	self observer clearTicks.
]

{ #category : 'thread ops' }
SMicroWorld >> clearTurtles [
	self turtleBreedsDo: [ :each | each clear ].
]

{ #category : 'accessing' }
SMicroWorld >> colors [
	| colors x y c index |
	colors := self patches colors copy.
	self
		turtlesDo: [ :id :ts | 
			x := ts xAt: id.
			y := ts yAt: id.
			c := ts colorAt: id.
			index := self patches indexAtPoint: x @ y.
			colors at: index put: c ].
	^ colors
]

{ #category : 'thread ops' }
SMicroWorld >> copyBreed: bid var: var to: var2 [
	(self breedOf: bid) copyVar: var to: var2
]

{ #category : 'accessing' }
SMicroWorld >> countAliveOf: bno [
	^ (self breedOf: bno) countAlive
]

{ #category : 'thread ops' }
SMicroWorld >> create: bid turtles: anInteger [
	bid < SBreedId defaultUserNo
		ifTrue: [ self error: 'breedId must be more than 2' ].
	^ (breeds at: bid) create: anInteger
]

{ #category : 'thread ops' }
SMicroWorld >> createPatch: anInteger [
	self clearTurtles.
	self patches create: anInteger.
]

{ #category : 'api' }
SMicroWorld >> deleteBreed: aBreed [
	| bno |
	bno := aBreed breedNo.
	(breeds at: bno) ifNil: [ self error ].
	breeds at: bno put: nil
]

{ #category : 'accessing variable' }
SMicroWorld >> delta: bno at: index [
	^ (breeds at: bno) deltaAt: index
]

{ #category : 'thread ops' }
SMicroWorld >> diffuse4: anInteger1 varNo: anInteger2 [

	self patches diffuse4: anInteger1 varNo: anInteger2
]

{ #category : 'thread ops' }
SMicroWorld >> diffuse8: anInteger1 varNo: anInteger2 [

	self patches diffuse8: anInteger1 varNo: anInteger2
]

{ #category : 'accessing' }
SMicroWorld >> extent [
	^ self patches extent
]

{ #category : 'accessing variable' }
SMicroWorld >> flag: anInteger breed: bid at: id [
	^ (breeds at: bid) flag: anInteger at: id
]

{ #category : 'accessing variable' }
SMicroWorld >> flag: anInteger breed: bid at: id put: aNumber [
	(breeds at: bid) flag: anInteger at: id put: aNumber
]

{ #category : 'thread ops' }
SMicroWorld >> forward: aNumber breed: bid id: anInteger [
	| c x y delta dx dy penDown rest h d ps ts distance |
	ps := breeds at: SBreedId patchesBreedNo.
	ts := breeds at: bid.
	penDown := ts penDownAt: anInteger.
	c := ts colorAt: anInteger.
	x := ts xAt: anInteger.
	y := ts yAt: anInteger.
	h := ts headingAt: anInteger.
	distance := aNumber.
	distance < 0
		ifTrue: [ distance := distance negated.
			h := (h + 180) \\ 360 ].
	delta := Point r: 1.0 degrees: h.
	dx := delta x.
	dy := delta y.
	distance truncated
		timesRepeat: [ penDown
				ifTrue: [ ps colorAtPoint: x @ y put: c ].
			x := x + dx.
			y := y + dy.
			x := ps normalize: x.
			y := ps normalize: y ].
	penDown
		ifTrue: [ ps colorAtPoint: x @ y put: c ].
	rest := distance - distance truncated.
	(rest closeTo: 0.0)
		ifFalse: [ d := Point r: rest degrees: h.
			x := x + d x.
			y := y + d y.
			x := ps normalize: x.
			y := ps normalize: y ].
	ts xAt: anInteger put: x.
	ts yAt: anInteger put: y
]

{ #category : 'thread ops' }
SMicroWorld >> hatch: bid id: anInteger [
	| list |
	list := self create: bid turtles: 1.
	list do: [ :each | (breeds at: bid) copyTurtleFrom: anInteger to: each ].
]

{ #category : 'api' }
SMicroWorld >> incrementTicks [
	self observer incrementTicks.
]

{ #category : 'initialization' }
SMicroWorld >> initialize [
	super initialize.
	random := SharedRandom globalGenerator.
	self reset
]

{ #category : 'thread ops' }
SMicroWorld >> kill: bid at: anInteger [
	(bid = SBreedId observerBreedNo or: [ bid = SBreedId patchesBreedNo ])
		ifTrue: [ ^ self ].
	self flag: STurtlesVarDef aliveFlagNo breed: bid at: anInteger put: false
]

{ #category : 'enumerating' }
SMicroWorld >> livingBreed: bno do: aBlock [
	(breeds at: bno) livingOnesDo: aBlock.
]

{ #category : 'accessing' }
SMicroWorld >> maxBreedNo [
	^ breeds size
]

{ #category : 'thread ops' }
SMicroWorld >> multiplyBreed: bid var: var by: aNumber [
	(self breedOf: bid) multiply: var by: aNumber
]

{ #category : 'instance creation' }
SMicroWorld >> newProcess [

	^ SteloNativeProcess sworld: self
]

{ #category : 'thread ops' }
SMicroWorld >> nsum4: anInteger1 to: anInteger2 [

	self patches nsum4: anInteger1 to: anInteger2
]

{ #category : 'thread ops' }
SMicroWorld >> nsum8: anInteger1 to: anInteger2 [

	self patches nsum8: anInteger1 to: anInteger2
]

{ #category : 'accessing' }
SMicroWorld >> observer [
	^ breeds at: SBreedId observerBreedNo
]

{ #category : 'thread ops' }
SMicroWorld >> patchIndexAtX: x y: y [
	^ self patches indexAtX: x y: y
]

{ #category : 'accessing' }
SMicroWorld >> patches [
	^ breeds at: SBreedId patchesBreedNo
]

{ #category : 'thread ops' }
SMicroWorld >> plot: anInteger color: color [
	| c |
	c := ColorList default colorAt: color.
	plotList add: (ScratchPlot channel: anInteger color: c)
]

{ #category : 'thread ops' }
SMicroWorld >> plot: anInteger data: aFloat [
	plotList add: (ScratchPlot channel: anInteger data: aFloat)
]

{ #category : 'accessing' }
SMicroWorld >> plotList [
	| tmp |
	tmp := plotList.
	plotList := OrderedCollection new.
	^ tmp
]

{ #category : 'accessing' }
SMicroWorld >> plotList: aCollection [
	plotList := aCollection
]

{ #category : 'printing' }
SMicroWorld >> printOn: aStream [
	aStream
		nextPutAll: 'MicroWorld(';
		print: self identityHash;
		nextPut: $).
]

{ #category : 'api' }
SMicroWorld >> raiseEvent: anInteger [
	raisedEvents add: anInteger.
]

{ #category : 'accessing' }
SMicroWorld >> raisedEvents [
	^ raisedEvents
]

{ #category : 'accessing' }
SMicroWorld >> raisedEvents: aCollection [
	raisedEvents := aCollection
]

{ #category : 'accessing' }
SMicroWorld >> random [
	^ random
]

{ #category : 'accessing' }
SMicroWorld >> random: anObject [

	random := anObject
]

{ #category : 'thread ops' }
SMicroWorld >> randomFrom: aNumber to: aNumber2 [
	^ (aNumber to: aNumber2) atRandom: random
]

{ #category : 'api' }
SMicroWorld >> reset [
	raisedEvents := Set new.
	breeds := Array new.
	plotList := OrderedCollection new
]

{ #category : 'thread ops' }
SMicroWorld >> scaleVar: v color: c breed: bid from: f to: t id: id [
	bid = SBreedId observerBreedNo
		ifTrue: [ self patches
				scaleVarNo: v
				color: c
				from: f
				to: t ]
		ifFalse: [ (breeds at: bid)
				scaleVarNo: v
				color: c
				from: f
				to: t
				index: id ]
]

{ #category : 'thread ops' }
SMicroWorld >> setPlotYMax: aNumber [
	plotList add: (ScratchPlot setPlotYMax: aNumber)
]

{ #category : 'thread ops' }
SMicroWorld >> setPlotYMin: aNumber [
	plotList add: (ScratchPlot setPlotYMin: aNumber)
]

{ #category : 'thread ops' }
SMicroWorld >> setRandomSeed: aNumber [
	| seed |
	seed := aNumber asInteger.
	random := seed = 0
		ifTrue: [ SharedRandom globalGenerator ]
		ifFalse: [ Random seed: seed ]
]

{ #category : 'accessing' }
SMicroWorld >> sizeOf: bno [
	^ (self breedOf: bno) size
]

{ #category : 'accessing' }
SMicroWorld >> ticks [

	^ self observer ticks
]

{ #category : 'thread ops' }
SMicroWorld >> turtle: bno at: pos exceptBreed: myBno index: myIndex [
	| list |
	list := self turtles: bno at: pos.
	bno = myBno
		ifTrue: [ list remove: myIndex ifAbsent: [  ] ].
	^ list isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ list anyOne ]
]

{ #category : 'private' }
SMicroWorld >> turtleBreedsDo: aBlock [
	SBreedId defaultUserNo to: breeds size do: [ :each | 
		| turtle |
		turtle := self breedOf: each.
		turtle ifNotNil: [ aBlock value: turtle ] ]
]

{ #category : 'private' }
SMicroWorld >> turtles: bno at: pos [
	| list x y p |
	list := OrderedCollection new.
	self
		livingBreed: bno
		do: [ :tid :breed | 
			x := breed xAt: tid.
			y := breed yAt: tid.
			p := self patches indexAtPoint: x @ y.
			p = pos
				ifTrue: [ list add: tid ] ].
	^ list
]

{ #category : 'private' }
SMicroWorld >> turtlesDo: aBlock [
	self turtleBreedsDo: [ :ts | ts livingOnesDo: aBlock ]
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bid at: id [

	bid = SBreedId observerBreedNo ifTrue: [ 
		anInteger = SObserverVarDef widthVarNo ifTrue: [ ^ self extent x ].
		anInteger = SObserverVarDef heightVarNo ifTrue: [ ^ self extent y ].
		anInteger = SObserverVarDef maxBreedNoVarNo ifTrue: [ 
			^ self maxBreedNo ].
		anInteger = SObserverVarDef countAliveVarNo ifTrue: [ 
			^ self countAliveOf: id ].
		anInteger = SObserverVarDef sizeVarNo ifTrue: [ ^ self sizeOf: id ] ].
	^ (breeds at: bid) var: anInteger at: id
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bid at: id put: aNumber [

	(breeds at: bid) var: anInteger at: id put: aNumber
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bno list: id [
	^ (self breedOf: bno) var: anInteger list: id
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bno list: id add: aNumber [
	(self breedOf: bno) var: anInteger list: id add: aNumber
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bno list: id at: anInteger2 [
	^ (self breedOf: bno) var: anInteger list: id at: anInteger2
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bno list: id at: anInteger2 put: aNumber [
	(self breedOf: bno) var: anInteger list: id at: anInteger2 put: aNumber
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bno list: id contains: aNumber [
	^ (self breedOf: bno) var: anInteger list: id contains: aNumber
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bno list: id remove: aNumber [
	(self breedOf: bno) var: anInteger list: id remove: aNumber
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bno list: id set: aCollection [
	(self breedOf: bno) var: anInteger list: id set: aCollection
]

{ #category : 'accessing variable' }
SMicroWorld >> var: anInteger breed: bno listSizeOf: id [
	^ (self breedOf: bno) var: anInteger listSizeOf: id
]

{ #category : 'accessing' }
SMicroWorld >> worldName [

	^ 'MicroWorld'
]

{ #category : 'accessing variable' }
SMicroWorld >> x: breed at: id [
	^ (breeds at: breed) xAt: id
]

{ #category : 'accessing variable' }
SMicroWorld >> x: bid at: anInteger put: aNumber [
	| c x y dx penDown ps ts |
	ps := breeds at: SBreedId patchesBreedNo.
	ts := breeds at: bid.
	penDown := ts penDownAt: anInteger.
	c := ts colorAt: anInteger.
	x := ts xAt: anInteger.
	y := ts yAt: anInteger.
	dx := (aNumber - x) sign.
	(aNumber - x) truncated abs
		timesRepeat: [ penDown
				ifTrue: [ ps colorAtPoint: x @ y put: c ].
			x := x + dx.
			x := ps normalize: x ].
	penDown
		ifTrue: [ ps colorAtPoint: x @ y put: c ].
	(x closeTo: aNumber)
		ifFalse: [ x := ps normalize: aNumber ].
	ts xAt: anInteger put: x
]

{ #category : 'accessing variable' }
SMicroWorld >> y: breed at: id [
	^ (breeds at: breed) yAt: id
]

{ #category : 'accessing variable' }
SMicroWorld >> y: bid at: anInteger put: aNumber [
	| c x y dy penDown ps ts |
	ps := breeds at: SBreedId patchesBreedNo.
	ts := breeds at: bid.
	penDown := ts penDownAt: anInteger.
	c := ts colorAt: anInteger.
	x := ts xAt: anInteger.
	y := ts yAt: anInteger.
	dy := (aNumber - y) sign.
	(aNumber - y) truncated abs
		timesRepeat: [ penDown
				ifTrue: [ ps colorAtPoint: x @ y put: c ].
			y := y + dy.
			y := ps normalize: y ].
	penDown
		ifTrue: [ ps colorAtPoint: x @ y put: c ].
	(y closeTo: aNumber)
		ifFalse: [ y := ps normalize: aNumber ].
	ts yAt: anInteger put: y
]

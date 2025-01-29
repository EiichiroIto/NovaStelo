Class {
	#name : 'SteloNativeThread',
	#superclass : 'ScratchNativeThread',
	#instVars : [
		'world',
		'breedId'
	],
	#category : 'Stelo-Process',
	#package : 'Stelo',
	#tag : 'Process'
}

{ #category : 'acccessing' }
SteloNativeThread class >> generateSymbols [
	"self generateSymbols inspect."
	| w |
	self setupCachedSymbols.
	w := WriteStream on: ''.
	w
		nextPutAll: 'enum SteloSymbol {';
		nextPutAll: String lf;
		nextPutAll: '  SS_nop = -1,';
		nextPutAll: String lf.
	cachedSymbols
		withIndexDo: [ :each :index | 
			w
				nextPutAll: '  SS_';
				nextPutAll: each;
				nextPutAll: ',';
				nextPutAll: ' /* ';
				nextPutAll: (index - 1) asString;
				nextPutAll: ' */';
				nextPutAll: String lf ].
	w
		nextPutAll: '};';
		nextPutAll: String lf.
	^ w contents
]

{ #category : 'instance creation' }
SteloNativeThread class >> new [
	self shouldNotImplement
]

{ #category : 'instance creation' }
SteloNativeThread class >> sworld: aMicroWorld [
	^ self basicNew
		initialize;
		sworld: aMicroWorld;
		yourself.
]

{ #category : 'turtle ops' }
SteloNativeThread >> aimHigh [
	| var ret |
	var := self pop.
	ret := world aimHighPatchVar: var breed: breedId id: id.
	self push: ret.
]

{ #category : 'list ops' }
SteloNativeThread >> appendToList [
	| vno val |
	val := self pop.
	vno := self pop.
	world
		var: vno
		breed: breedId
		list: id
		add: val
]

{ #category : 'accessing' }
SteloNativeThread >> breedId [
	^ breedId
]

{ #category : 'accessing' }
SteloNativeThread >> breedId: anObject [
	breedId := anObject
]

{ #category : 'misc ops' }
SteloNativeThread >> broadcast [
	| eventId |
	eventId := self pop.
	world raiseEvent: eventId asInteger.
]

{ #category : 'observer ops' }
SteloNativeThread >> changeBreedVarBy [
	| var p bid |
	bid := self pop.
	var := self pop.
	p := self pop.
	world changeBreed: bid var: var by: p
]

{ #category : 'observer ops' }
SteloNativeThread >> clearBreed [
	| bno |
	bno := self pop.
	world clearBreed: bno.
]

{ #category : 'list ops' }
SteloNativeThread >> clearList [
	| vno |
	vno := self pop.
	world
		var: vno
		breed: breedId
		list: id
		set: #()
]

{ #category : 'misc ops' }
SteloNativeThread >> clearPlots [
	world clearPlots
]

{ #category : 'observer ops' }
SteloNativeThread >> clearTurtles [
	world clearTurtles.
]

{ #category : 'observer ops' }
SteloNativeThread >> copyBreedVarTo [
	| bid var var2 |
	bid := self pop.
	var := self pop.
	var2 := self pop.
	world copyBreed: bid var: var to: var2
]

{ #category : 'observer ops' }
SteloNativeThread >> createPatch [
	| count |
	count := self pop.
	world createPatch: count asInteger.
]

{ #category : 'observer ops' }
SteloNativeThread >> createTurtles [
	| count bid |
	bid := self pop.
	count := self pop.
	world create: bid asInteger turtles: count asInteger.
]

{ #category : 'list ops' }
SteloNativeThread >> deleteLineOfList [
	| vno index |
	index := self pop.
	vno := self pop.
	world
		var: vno
		breed: breedId
		list: id
		remove: index
]

{ #category : 'observer ops' }
SteloNativeThread >> diffuse [
	| v p |
	p := self pop.
	v := self pop.
	world diffuse8: p varNo: v.
]

{ #category : 'observer ops' }
SteloNativeThread >> diffuse4 [
	| v p |
	p := self pop.
	v := self pop.
	world diffuse4: p varNo: v.
]

{ #category : 'turtle ops' }
SteloNativeThread >> dx [
	| delta |
	delta := world delta: breedId at: id.
	self push: delta x
]

{ #category : 'turtle ops' }
SteloNativeThread >> dy [
	| delta |
	delta := world delta: breedId at: id.
	self push: delta y
]

{ #category : 'api' }
SteloNativeThread >> forBreedNo: bno index: anInteger [
	breedId := bno.
	id := anInteger.
]

{ #category : 'api' }
SteloNativeThread >> forObserver [
	self forBreedNo: SBreedId observerBreedNo index: 1.
]

{ #category : 'api' }
SteloNativeThread >> forPatchId: anInteger [
	self forBreedNo: SBreedId patchesBreedNo index: anInteger.
]

{ #category : 'turtle ops' }
SteloNativeThread >> forward [
	| step |
	step := self pop.
	world forward: step breed: breedId id: id.
]

{ #category : 'variable ops' }
SteloNativeThread >> getBreedId [
	self push: breedId.
]

{ #category : 'variable ops' }
SteloNativeThread >> getBreedVar [
	| var index bno ret |
	bno := self pop.
	var := self pop.
	index := self pop asInteger.
	ret := world var: var breed: bno at: index.
	self push: ret.
]

{ #category : 'list ops' }
SteloNativeThread >> getLineOfList [
	| vno index ret |
	index := self pop.
	vno := self pop.
	ret := world
		var: vno
		breed: breedId
		list: id
		at: index.
	self push: ret
]

{ #category : 'variable ops' }
SteloNativeThread >> getVar [
	| var ret |
	var := self pop.
	ret := world var: var breed: breedId at: id.
	self push: ret.
]

{ #category : 'variable ops' }
SteloNativeThread >> getX [
	| ret |
	ret := world x: breedId at: id.
	self push: ret.
]

{ #category : 'variable ops' }
SteloNativeThread >> getY [
	| ret |
	ret := world y: breedId at: id.
	self push: ret.
]

{ #category : 'turtle ops' }
SteloNativeThread >> hatch [
	world hatch: breedId id: id.
]

{ #category : 'turtle ops' }
SteloNativeThread >> kill [
	| tid bid |
	tid := self pop.
	bid := self pop.
	world kill: bid at: tid.
	(breedId = bid and: [ id = tid ])
		ifTrue: [ self stop ]
]

{ #category : 'list ops' }
SteloNativeThread >> lineCountOfList [
	| vno ret |
	vno := self pop.
	ret := world
		var: vno
		breed: breedId
		listSizeOf: id.
	self push: ret
]

{ #category : 'list ops' }
SteloNativeThread >> listContains [
	| vno val ret |
	val := self pop.
	vno := self pop.
	ret := world
		var: vno
		breed: breedId
		list: id
		contains: val.
	self push: ret
]

{ #category : 'observer ops' }
SteloNativeThread >> multiplyBreedVarBy [
	| var p bid |
	bid := self pop.
	var := self pop.
	p := self pop.
	world multiplyBreed: bid var: var by: p
]

{ #category : 'observer ops' }
SteloNativeThread >> nsum [
	| v1 v2 |
	v2 := self pop.
	v1 := self pop.
	world nsum8: v1 to: v2.
]

{ #category : 'observer ops' }
SteloNativeThread >> nsum4 [
	| v1 v2 |
	v2 := self pop.
	v1 := self pop.
	world nsum4: v1 to: v2.
]

{ #category : 'patch ops' }
SteloNativeThread >> patchAt [
	| x y ret |
	y := self pop.
	x := self pop.
	ret := world patchIndexAtX: x y: y.
	self push: ret.
]

{ #category : 'misc ops' }
SteloNativeThread >> plotColor [
	| num color |
	color := self pop.
	num := self pop.
	world plot: num asInteger color: color asInteger
]

{ #category : 'misc ops' }
SteloNativeThread >> plotData [
	| num data |
	data := self pop.
	num := self pop.
	world plot: num asInteger data: data
]

{ #category : 'misc ops' }
SteloNativeThread >> randomFromTo [
	| to from result |
	to := self pop.
	from := self pop.
	result := world randomFrom: from to: to.
	self push: result.
]

{ #category : 'variable ops' }
SteloNativeThread >> scaleColorFromTo [
	| v c f t |
	t := self pop.
	f := self pop.
	c := self pop.
	v := self pop.
	world scaleVar: v color: c breed: breedId from: f to: t id: id.
]

{ #category : 'variable ops' }
SteloNativeThread >> setBreedVarTo [
	| var val index bno |
	bno := self pop.
	var := self pop.
	val := self pop.
	index := self pop asInteger.
	world
		var: var
		breed: bno
		at: index
		put: val
]

{ #category : 'variable ops' }
SteloNativeThread >> setColorTo [
	| color |
	color := self pop.
	world var: STurtlesVarDef colorVarNo breed: breedId at: id put: color.
]

{ #category : 'variable ops' }
SteloNativeThread >> setHeading [
	| degrees |
	breedId <= SBreedId patchesBreedNo
		ifTrue: [ ^ self ].
	degrees := self pop.
	world var: STurtlesVarDef headingVarNo breed: SBreedId turtlesBreedNo at: id put: degrees.
]

{ #category : 'list ops' }
SteloNativeThread >> setLineOfListTo [
	| vno val index |
	vno := self pop.
	val := self pop.
	index := self pop.
	world
		var: vno
		breed: breedId
		list: id
		at: index
		put: val
]

{ #category : 'variable ops' }
SteloNativeThread >> setPatchColorTo [
	| color pid |
	color := self pop.
	pid := self pop.
	world var: SPatchesVarDef colorVarNo breed: SBreedId patchesBreedNo at: pid put: color.
]

{ #category : 'misc ops' }
SteloNativeThread >> setPlotYMax [
	| n |
	n := self pop.
	world setPlotYMax: n
]

{ #category : 'misc ops' }
SteloNativeThread >> setPlotYMin [
	| n |
	n := self pop.
	world setPlotYMin: n
]

{ #category : 'observer ops' }
SteloNativeThread >> setRandomSeed [
	| num |
	num := self pop.
	world setRandomSeed: num asInteger
]

{ #category : 'variable ops' }
SteloNativeThread >> setVarTo [
	| var val |
	val := self pop.
	var := self pop.
	world
		var: var
		breed: breedId
		at: id
		put: val
]

{ #category : 'turtle ops' }
SteloNativeThread >> setX [
	| v |
	breedId <= SBreedId patchesBreedNo
		ifTrue: [ ^ self ].
	v := self pop.
	world x: breedId at: id put: v
]

{ #category : 'turtle ops' }
SteloNativeThread >> setY [
	| v |
	breedId <= SBreedId patchesBreedNo
		ifTrue: [ ^ self ].
	v := self pop.
	world y: breedId at: id put: v
]

{ #category : 'accessing' }
SteloNativeThread >> sworld [
	^ world
]

{ #category : 'accessing' }
SteloNativeThread >> sworld: anObject [
	world := anObject
]

{ #category : 'turtle ops' }
SteloNativeThread >> turtleAt [
	| ret bid pno |
	bid := self pop.
	pno := self pop.
	ret := world
		turtle: bid
		at: pno
		exceptBreed: breedId
		index: id.
	self push: ret
]

{ #category : 'patch ops' }
SteloNativeThread >> xyOf [

	| pno x y |
	pno := self pop.
	x := world x: SBreedId patchesBreedNo at: pno.
	y := world y: SBreedId patchesBreedNo at: pno.
	self push: x.
	self push: y
]

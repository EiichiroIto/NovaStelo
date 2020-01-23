Class {
	#name : #SteloNativeThread,
	#superclass : #ScratchNativeThread,
	#instVars : [
		'world',
		'breedId'
	],
	#category : #'Stelo-Process'
}

{ #category : #acccessing }
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

{ #category : #'instance creation' }
SteloNativeThread class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
SteloNativeThread class >> sworld: aMicroWorld [
	^ self basicNew
		initialize;
		privSWorld: aMicroWorld;
		yourself.
]

{ #category : #'turtle ops' }
SteloNativeThread >> aimHigh [
	| var ret |
	var := self pop.
	ret := world aimHighPatchVar: var breed: breedId id: id.
	self push: ret.
]

{ #category : #'list ops' }
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

{ #category : #'misc ops' }
SteloNativeThread >> broadcast [
	| eventId |
	eventId := self pop.
	world raiseEvent: eventId asInteger.
]

{ #category : #'observer ops' }
SteloNativeThread >> clearBreed [
	| bno |
	bno := self pop.
	world clearBreed: bno.
]

{ #category : #'list ops' }
SteloNativeThread >> clearList [
	| vno |
	vno := self pop.
	world
		var: vno
		breed: breedId
		list: id
		set: #()
]

{ #category : #'misc ops' }
SteloNativeThread >> clearPlots [
	world clearPlots
]

{ #category : #'observer ops' }
SteloNativeThread >> clearTurtles [
	world clearTurtles.
]

{ #category : #'observer ops' }
SteloNativeThread >> createPatch [
	| count |
	count := self pop.
	world createPatch: count asInteger.
]

{ #category : #'observer ops' }
SteloNativeThread >> createTurtles [
	| count bid |
	bid := self pop.
	count := self pop.
	world create: bid asInteger turtles: count asInteger.
]

{ #category : #'list ops' }
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

{ #category : #'observer ops' }
SteloNativeThread >> diffuse [
	| v p |
	p := self pop.
	v := self pop.
	world patches diffuse8: p varNo: v.
]

{ #category : #'observer ops' }
SteloNativeThread >> diffuse4 [
	| v p |
	p := self pop.
	v := self pop.
	world patches diffuse4: p varNo: v.
]

{ #category : #'turtle ops' }
SteloNativeThread >> dx [
	| delta |
	delta := world delta: breedId at: id.
	self push: delta x
]

{ #category : #'turtle ops' }
SteloNativeThread >> dy [
	| delta |
	delta := world delta: breedId at: id.
	self push: delta y
]

{ #category : #accessing }
SteloNativeThread >> forBreedNo: bno index: anInteger [
	breedId := bno.
	id := anInteger.
]

{ #category : #accessing }
SteloNativeThread >> forObserver [
	self forBreedNo: SBreedId observerBreedNo index: 1.
]

{ #category : #accessing }
SteloNativeThread >> forPatchId: anInteger [
	self forBreedNo: SBreedId patchBreedNo index: anInteger.
]

{ #category : #'turtle ops' }
SteloNativeThread >> forward [
	| step |
	step := self pop.
	world forward: step breed: breedId id: id.
]

{ #category : #'variable ops' }
SteloNativeThread >> getBreedId [
	self push: breedId.
]

{ #category : #'variable ops' }
SteloNativeThread >> getBreedVar [
	| var index bno ret |
	bno := self pop.
	var := self pop.
	index := self pop.
	ret := world var: var breed: bno at: index.
	self push: ret.
]

{ #category : #'list ops' }
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

{ #category : #'variable ops' }
SteloNativeThread >> getVar [
	| var ret |
	var := self pop.
	ret := world var: var breed: breedId at: id.
	self push: ret.
]

{ #category : #'variable ops' }
SteloNativeThread >> getX [
	| ret |
	ret := world x: breedId at: id.
	self push: ret.
]

{ #category : #'variable ops' }
SteloNativeThread >> getY [
	| ret |
	ret := world y: breedId at: id.
	self push: ret.
]

{ #category : #'turtle ops' }
SteloNativeThread >> hatch [
	world hatch: breedId id: id.
]

{ #category : #'turtle ops' }
SteloNativeThread >> kill [
	| tid bid |
	breedId <= SBreedId patchBreedNo
		ifTrue: [ ^ self ].
	tid := self pop.
	bid := self pop.
	world kill: bid at: tid.
	(breedId = bid and: [ id = tid ])
		ifTrue: [ self stop ]
]

{ #category : #'list ops' }
SteloNativeThread >> lineCountOfList [
	| vno ret |
	vno := self pop.
	ret := world
		var: vno
		breed: breedId
		listSizeOf: id.
	self push: ret
]

{ #category : #'list ops' }
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

{ #category : #'observer ops' }
SteloNativeThread >> multiplyBy [
	| v p |
	p := self pop.
	v := self pop.
	world patches multiplyBy: p varNo: v.
]

{ #category : #'observer ops' }
SteloNativeThread >> nsum [
	| v1 v2 |
	v2 := self pop.
	v1 := self pop.
	world patches nsum8: v1 to: v2.
]

{ #category : #'observer ops' }
SteloNativeThread >> nsum4 [
	| v1 v2 |
	v2 := self pop.
	v1 := self pop.
	world patches nsum4: v1 to: v2.
]

{ #category : #'patch ops' }
SteloNativeThread >> patchAt [
	| x y ret |
	y := self pop.
	x := self pop.
	ret := world patchIndexAtX: x y: y.
	self push: ret.
]

{ #category : #'misc ops' }
SteloNativeThread >> plotColor [
	| num color |
	color := self pop.
	num := self pop.
	world plot: num asInteger color: color asInteger
]

{ #category : #'misc ops' }
SteloNativeThread >> plotData [
	| num data |
	data := self pop.
	num := self pop.
	world plot: num asInteger data: data
]

{ #category : #private }
SteloNativeThread >> privBreedId [
	^ breedId
]

{ #category : #private }
SteloNativeThread >> privBreedId: anObject [
	breedId := anObject
]

{ #category : #private }
SteloNativeThread >> privSWorld [
	^ world
]

{ #category : #private }
SteloNativeThread >> privSWorld: anObject [
	world := anObject
]

{ #category : #'variable ops' }
SteloNativeThread >> scaleColorFromTo [
	| v c f t |
	t := self pop.
	f := self pop.
	c := self pop.
	v := self pop.
	world scaleVar: v color: c breed: breedId from: f to: t id: id.
]

{ #category : #'variable ops' }
SteloNativeThread >> setBreedVarTo [
	| var val index bno |
	bno := self pop.
	var := self pop.
	val := self pop.
	index := self pop.
	world
		var: var
		breed: bno
		at: index
		put: val
]

{ #category : #'variable ops' }
SteloNativeThread >> setColorTo [
	| color |
	color := self pop.
	world var: STurtleVarDef colorVarNo breed: breedId at: id put: color.
]

{ #category : #'variable ops' }
SteloNativeThread >> setHeading [
	| degrees |
	breedId <= SBreedId patchBreedNo
		ifTrue: [ ^ self ].
	degrees := self pop.
	world var: STurtleVarDef headingVarNo breed: SBreedId turtleBreedNo at: id put: degrees.
]

{ #category : #'list ops' }
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

{ #category : #'variable ops' }
SteloNativeThread >> setPatchColorTo [
	| color pid |
	color := self pop.
	pid := self pop.
	world var: SPatchVarDef colorVarNo breed: SBreedId patchBreedNo at: pid put: color.
]

{ #category : #'misc ops' }
SteloNativeThread >> setPlotYMax [
	| n |
	n := self pop.
	world setPlotYMax: n
]

{ #category : #'misc ops' }
SteloNativeThread >> setPlotYMin [
	| n |
	n := self pop.
	world setPlotYMin: n
]

{ #category : #'variable ops' }
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

{ #category : #'turtle ops' }
SteloNativeThread >> setX [
	| v |
	breedId <= SBreedId patchBreedNo
		ifTrue: [ ^ self ].
	v := self pop.
	world x: breedId at: id put: v
]

{ #category : #'turtle ops' }
SteloNativeThread >> setY [
	| v |
	breedId <= SBreedId patchBreedNo
		ifTrue: [ ^ self ].
	v := self pop.
	world y: breedId at: id put: v
]

{ #category : #'turtle ops' }
SteloNativeThread >> turtleAt [
	| x y ret bid pno |
	bid := self pop.
	pno := self pop.
	x := world patches xAt: pno.
	y := world patches yAt: pno.
	ret := world turtle: bid x: x y: y exceptBreed: breedId index: id.
	self push: ret.
]

{ #category : #'patch ops' }
SteloNativeThread >> xyOf [
	| pno x y |
	pno := self pop.
	x := world patches xAt: pno.
	y := world patches yAt: pno.
	self push: x.
	self push: y.
]

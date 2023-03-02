Class {
	#name : #SPluginWorld,
	#superclass : #SteloWorld,
	#instVars : [
		'plugin'
	],
	#category : #'Stelo-Plugins'
}

{ #category : #api }
SPluginWorld >> addBreed: aBreed [
	| bno |
	bno := aBreed breedNo.
	plugin setupBreed: bno.
	bno = SBreedId patchesBreedNo
		ifTrue: [ plugin createPatch: aBreed order ].
	bno = SBreedId turtlesBreedNo
		ifTrue: [ plugin create: bno turtles: aBreed size ].
	self addVariablesFor: aBreed.
	self setAllVariables: aBreed
]

{ #category : #api }
SPluginWorld >> addVariable: aString var: vno breed: bno [
	plugin addVariable: vno breed: bno
]

{ #category : #private }
SPluginWorld >> addVariablesFor: aBreed [
	| bno |
	bno := aBreed breedNo.
	aBreed userDefinedVarNoAndNames
		do: [ :each | plugin addVariable: each first breed: bno ].
]

{ #category : #api }
SPluginWorld >> clearBreed: anInteger [
	plugin clearBreed: anInteger.
]

{ #category : #accessing }
SPluginWorld >> colors [
	| num ext |
	num := self sizeOf: SBreedId patchesBreedNo.
	ext := plugin getScreen.
	^ [ ext copyFrom: 1 to: num ]
		ensure: [ ext release ]
]

{ #category : #accessing }
SPluginWorld >> countAliveOf: bno [
	^ (plugin
		getFloat: SObserverVarDef countAliveVarNo
		breed: SBreedId observerBreedNo
		id: bno) truncated
]

{ #category : #api }
SPluginWorld >> create: bno turtles: anInteger [
	plugin create: bno turtles: anInteger
]

{ #category : #api }
SPluginWorld >> createPatch: anInteger [
	plugin createPatch: anInteger.
]

{ #category : #api }
SPluginWorld >> deleteBreed: aBreed [

	self shouldBeImplemented
]

{ #category : #accessing }
SPluginWorld >> extent [
	^ self getCols @ self getRows
]

{ #category : #'accessing variable' }
SPluginWorld >> flag: anInteger breed: bno at: id [
	| v b |
	v := self var: STurtlesVarDef flagVarNo breed: bno at: id.
	b := 1 << anInteger.
	^ (v bitAnd: b) > 0
]

{ #category : #'accessing variable' }
SPluginWorld >> flag: anInteger breed: bno at: id put: aBoolean [
	| v b |
	v := self var: STurtlesVarDef flagVarNo breed: bno at: id.
	b := 1 << anInteger.
	v := aBoolean
		ifTrue: [ v bitOr: b ]
		ifFalse: [ v bitClear: b ].
	self var: STurtlesVarDef flagVarNo breed: bno at: id put: v
]

{ #category : #private }
SPluginWorld >> getAllVariable: vno breed: bno [
	| type |
	"bno = SBreedId observerBreedNo ifTrue: [ ^ nil ]."
	type := plugin getType: vno breed: bno.
	"type = SteloLibCall word
		ifTrue: [ ^ self getWordAll: vno breed: bno ]."
	type = SteloLibCall float
		ifTrue: [ ^ self getFloatAll: vno breed: bno ].
	type = SteloLibCall byte
		ifTrue: [ ^ self getByteAll: vno breed: bno ].
	^ nil
]

{ #category : #private }
SPluginWorld >> getAllVariables: aBreed [
	| bno |
	bno := aBreed breedNo.
	aBreed realVarNames
		do: [ :each | 
			| vno list |
			vno := aBreed varNoFor: each.
			list := self getAllVariable: vno breed: bno.
			list ifNotNil: [ aBreed varArrayNamed: each put: list ] ]
]

{ #category : #private }
SPluginWorld >> getByteAll: vno breed: bno [
	| size ptr |
	size := self sizeOf: bno.
	ptr := plugin getByteAll: vno breed: bno.
	ptr isNull
		ifTrue: [ ^ nil ].
	^ [ ptr copyFrom: 1 to: size ]
		ensure: [ ptr autoRelease ]
]

{ #category : #private }
SPluginWorld >> getCols [
	^ (plugin
		getFloat: SObserverVarDef widthVarNo
		breed: SBreedId observerBreedNo
		id: 1) truncated
]

{ #category : #private }
SPluginWorld >> getFloatAll: vno breed: bno [
	| size ptr ext arr |
	size := self sizeOf: bno.
	ptr := plugin getFloatAll: vno breed: bno.
	ptr isNull
		ifTrue: [ ^ nil ].
	ext := FFIExternalArray
		fromHandle: ptr getHandle
		type: ExternalType float.
	[ arr := FloatArray new: size withAll: 0.0.
	1 to: size do: [ :each | arr at: each put: (ext at: each) ] ]
		ensure: [ ptr autoRelease ].
	^ arr
]

{ #category : #private }
SPluginWorld >> getRows [
	^ (plugin
		getFloat: SObserverVarDef heightVarNo
		breed: SBreedId observerBreedNo
		id: 1) truncated
]

{ #category : #initialization }
SPluginWorld >> initialize [
	super initialize.
	plugin := SteloLibCall new.
]

{ #category : #testing }
SPluginWorld >> isPluginWorld [
	^ true
]

{ #category : #'instance creation' }
SPluginWorld >> newProcess [

	^ SPluginProcess sworld: self
]

{ #category : #accessing }
SPluginWorld >> patchIndexAtX: x y: y [
	^ plugin patchIndexAtX: x y: y
]

{ #category : #accessing }
SPluginWorld >> plotList [
	^ #()
]

{ #category : #accessing }
SPluginWorld >> plugin [
	^ plugin
]

{ #category : #api }
SPluginWorld >> reset [
	plugin reset
]

{ #category : #api }
SPluginWorld >> retrieveBreed: aBreed [

	self getAllVariables: aBreed
]

{ #category : #private }
SPluginWorld >> setAllVariable: vno breed: bno list: list [
	| type |
	list ifNil: [ ^ self ].
	type := plugin getType: vno breed: bno.
	"type = SteloLibCall word
		ifTrue: [ ^ self setWordAll: vno breed: bno from: list ]."
	type = SteloLibCall float
		ifTrue: [ ^ self setFloatAll: vno breed: bno from: list ].
	type = SteloLibCall byte
		ifTrue: [ ^ self setByteAll: vno breed: bno from: list ]
]

{ #category : #private }
SPluginWorld >> setAllVariables: aBreed [
	| bno |
	bno := aBreed breedNo.
	aBreed realVarNames
		do: [ :each | 
			| vno list |
			vno := aBreed varNoFor: each.
			list := aBreed varArrayNamed: each.
			self setAllVariable: vno breed: bno list: list ]
]

{ #category : #private }
SPluginWorld >> setByteAll: vno breed: bno from: aByteArray [
	| ext |
	ext := FFIExternalArray externalNewType: 'byte' size: aByteArray size.
	[ aByteArray withIndexDo: [ :each :index | ext at: index put: each ].
	plugin
		setByteAll: vno
		breed: bno
		extArray: ext
		size: aByteArray size ]
		ensure: [ ext free ]
]

{ #category : #private }
SPluginWorld >> setFloatAll: vno breed: bno from: aFloatArray [
	| ext |
	ext := FFIExternalArray
		externalNewType: 'float'
		size: aFloatArray size.
	[ aFloatArray withIndexDo: [ :each :index | ext at: index put: each ].
	plugin
		setFloatAll: vno
		breed: bno
		extArray: ext
		size: aFloatArray size ]
		ensure: [ ext free ]
]

{ #category : #private }
SPluginWorld >> setProgram: aProgram [
	| bytecode ext |
	bytecode := aProgram bytecode.
	ext := FFIExternalArray externalNewType: 'byte' size: bytecode size.
	[ bytecode withIndexDo: [ :each :index | ext at: index put: each ].
	plugin setProgram: ext size: bytecode size ]
		ensure: [ ext free ].
	aProgram entryPointList
		do: [ :each | 
			plugin
				addEntryPoint: each third
				eventNo: each first
				breedNo: each second ]
]

{ #category : #accessing }
SPluginWorld >> sizeOf: bno [
	^ (plugin
		getFloat: SObserverVarDef sizeVarNo
		breed: SBreedId observerBreedNo
		id: bno) truncated
]

{ #category : #private }
SPluginWorld >> turtles: bno at: pos [
	| xs ys flags mask list p |
	xs := self getAllVariable: STurtlesVarDef xVarNo breed: bno.
	ys := self getAllVariable: STurtlesVarDef yVarNo breed: bno.
	flags := self getAllVariable: STurtlesVarDef flagVarNo breed: bno.
	mask := 1 << STurtlesVarDef aliveFlagNo.
	list := OrderedCollection new.
	flags
		withIndexDo: [ :each :index | 
			p := self patchIndexAtX: (xs at: index) y: (ys at: index).
			((each bitAnd: mask) > 0 and: [ p = pos ])
				ifTrue: [ list add: index ] ].
	^ list
]

{ #category : #'accessing variable' }
SPluginWorld >> var: vno breed: bno at: tno [
	| t |
	t := plugin getType: vno breed: bno.
	t = SteloLibCall float
		ifTrue: [ ^ plugin getFloat: vno breed: bno id: tno ].
	t = SteloLibCall byte
		ifTrue: [ ^ plugin getByte: vno breed: bno id: tno ].
	"t = SteloLibCall word
		ifTrue: [ ^ plugin getWord: vno breed: bno id: tno ]."
	t = SteloLibCall computedFloat
		ifTrue: [ ^ plugin getFloat: vno breed: bno id: tno ].
	t = SteloLibCall none
		ifTrue: [ self error ]
]

{ #category : #'accessing variable' }
SPluginWorld >> var: vno breed: bno at: tno put: value [
	| t |
	t := plugin getType: vno breed: bno.
	t = SteloLibCall float
		ifTrue: [ ^ plugin
				setFloat: vno
				breed: bno
				id: tno
				value: value ].
	t = SteloLibCall byte
		ifTrue: [ ^ plugin
				setByte: vno
				breed: bno
				id: tno
				value: value ].
	"t = SteloLibCall word
		ifTrue: [ ^ plugin
				setWord: vno
				breed: bno
				id: tno
				value: value ]."
	t = SteloLibCall computedFloat
		ifTrue: [ self error ].
	t = SteloLibCall none
		ifTrue: [ self error ]
]

{ #category : #'accessing variable' }
SPluginWorld >> var: anInteger breed: bno list: id [

	"self subclassResponsibility"
]

{ #category : #'accessing variable' }
SPluginWorld >> var: anInteger breed: bno list: id set: aCollection [

	"self subclassResponsibility"
]

{ #category : #accessing }
SPluginWorld >> worldName [
	^ 'PluginWorld'
]

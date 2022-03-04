Class {
	#name : #SPluginWorld,
	#superclass : #SWorld,
	#instVars : [
		'plugin'
	],
	#category : #'Stelo-Plugins'
}

{ #category : #accessing }
SPluginWorld >> addBreed: aBreed [
	| bno |
	bno := aBreed breedNo.
	plugin setupBreed: bno.
	bno = SBreedId patchBreedNo
		ifTrue: [ plugin createPatch: aBreed order ].
	bno = SBreedId turtleBreedNo
		ifTrue: [ plugin create: bno turtles: aBreed size ].
	self addVariablesFor: aBreed.
	self setAllVariables: aBreed
]

{ #category : #accessing }
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

{ #category : #accessing }
SPluginWorld >> backupBreeds: aCollection [
	aCollection do: [ :each | self getAllVariables: each ].
]

{ #category : #accessing }
SPluginWorld >> clearBreed: anInteger [
	plugin clearBreed: anInteger.
]

{ #category : #accessing }
SPluginWorld >> colors [
	| num ext |
	num := self sizeOf: SBreedId patchBreedNo.
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

{ #category : #accessing }
SPluginWorld >> create: bno turtles: anInteger [
	plugin create: bno turtles: anInteger
]

{ #category : #accessing }
SPluginWorld >> createPatch: anInteger [
	plugin createPatch: anInteger.
]

{ #category : #accessing }
SPluginWorld >> extent [
	^ self getCols @ self getRows
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

{ #category : #private }
SPluginWorld >> processClass [
	^ SPluginProcess
]

{ #category : #accessing }
SPluginWorld >> reset [
	plugin reset
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

{ #category : #accessing }
SPluginWorld >> setDefaultTurtle: bno at: aPoint [
	plugin setDefaultTurtle: bno x: aPoint x y: aPoint y.
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
	xs := self getAllVariable: STurtleVarDef xVarNo breed: bno.
	ys := self getAllVariable: STurtleVarDef yVarNo breed: bno.
	flags := self getAllVariable: STurtleVarDef flagVarNo breed: bno.
	mask := 1 << STurtleVarDef aliveFlagNo.
	list := OrderedCollection new.
	flags
		withIndexDo: [ :each :index | 
			p := self patchIndexAtX: (xs at: index) y: (ys at: index).
			((each bitAnd: mask) > 0 and: [ p = pos ])
				ifTrue: [ list add: index ] ].
	^ list
]

{ #category : #accessing }
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

{ #category : #accessing }
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

{ #category : #accessing }
SPluginWorld >> worldName [
	^ 'PluginWorld'
]

Class {
	#name : #SPatches,
	#superclass : #SBreed,
	#instVars : [
		'order',
		'diffuser',
		'halfOrder',
		'negatedHalfOrder'
	],
	#category : #'Stelo-Model'
}

{ #category : #microworld }
SPatches >> aimHighVarNo: vid atPoint: aPoint direction: heading [
	| pos id delta forward left right |
	delta := Point r: 1.5 degrees: heading \\ 360.
	pos := aPoint + delta.
	id := self indexAtPoint: pos.
	forward := variables var: vid at: id.
	delta := Point r: 1.5 degrees: (heading + 45) \\ 360.
	pos := aPoint + delta.
	id := self indexAtPoint: pos.
	left := variables var: vid at: id.
	delta := Point r: 1.5 degrees: (heading - 45) \\ 360.
	pos := aPoint + delta.
	id := self indexAtPoint: pos.
	right := variables var: vid at: id.
	^ (forward >= left and: [ forward >= right ])
		ifTrue: [ 0 ]
		ifFalse: [ left >= right
				ifTrue: [ 45 ]
				ifFalse: [ -45 ] ].
]

{ #category : #accessing }
SPatches >> aliveAt: index [
	^ index between: 1 and: self size
]

{ #category : #accessing }
SPatches >> breedName [
	^ 'Patch'
]

{ #category : #accessing }
SPatches >> breedNo [
	^ SBreedId patchBreedNo
]

{ #category : #accessing }
SPatches >> breedNo: anInteger [
	"do nothing"
]

{ #category : #microworld }
SPatches >> breedsAtPoint: aPoint [
	^ { self indexAtPoint: aPoint }
]

{ #category : #microworld }
SPatches >> clear [
	super clear.
	variables forceSize: self size.
]

{ #category : #accessing }
SPatches >> colorAtPoint: aPoint [
	| index |
	index := self indexAtPoint: aPoint.
	^ self colorAt: index
]

{ #category : #accessing }
SPatches >> colorAtPoint: aPoint put: anInteger [
	| index |
	index := self indexAtPoint: aPoint.
	self colorAt: index put: anInteger
]

{ #category : #accessing }
SPatches >> cols [
	^ order
]

{ #category : #microworld }
SPatches >> create: anInteger [
	order := anInteger.
	self setupCaches.
	self clear.
]

{ #category : #private }
SPatches >> defaultOrder [
	^ 100
]

{ #category : #microworld }
SPatches >> diffuse4: anInteger1 varNo: anInteger2 [
	| buf |
	buf := variables realArrayAt: anInteger2.
	diffuser diffuse4: buf cols: order rows: order percent: anInteger1
]

{ #category : #microworld }
SPatches >> diffuse8: anInteger1 varNo: anInteger2 [
	| buf |
	buf := variables realArrayAt: anInteger2.
	diffuser diffuse8: buf cols: order rows: order percent: anInteger1
]

{ #category : #accessing }
SPatches >> diffuserName [
	^ diffuser diffuserName
]

{ #category : #accessing }
SPatches >> extent [
	^ order @ order
]

{ #category : #'object i/o' }
SPatches >> fieldsVersion [
	^ 1
]

{ #category : #private }
SPatches >> indexAtCol: c row: r [
	| i |
	i := (r - 1) * order + c.
	^ ((i - 1) \\ self size) + 1
]

{ #category : #private }
SPatches >> indexAtPoint: aPoint [
	| r c |
	c := aPoint x floor + (order // 2) + 1.
	r := aPoint y floor + (order // 2) + 1.
	^ self indexAtCol: c row: r
]

{ #category : #accessing }
SPatches >> indexAtX: x y: y [
	| x1 y1 |
	x1 := self normalize: x.
	y1 := self normalize: y.
	^ self indexAtPoint: x1 @ y1
]

{ #category : #'object i/o' }
SPatches >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(order) from: anObjStream.
	self setupCaches.
]

{ #category : #initialization }
SPatches >> initialize [
	super initialize.
	diffuser := SDiffuser pluginOrNativeClass new.
	self create: self defaultOrder.
]

{ #category : #microworld }
SPatches >> livingOnesDo: aBlock [
	1 to: self size do: [ :each | aBlock value: each ].
]

{ #category : #microworld }
SPatches >> multiplyBy: aNumber varNo: anInteger [
	variables multiply: anInteger by: aNumber
]

{ #category : #accessing }
SPatches >> normalize: aNumber [
	| h x |
	x := aNumber.
	h := order / 2.
	x := x \\ order.
	x >= h ifTrue: [ x := x - order ].
	^ x
]

{ #category : #microworld }
SPatches >> nsum4: anInteger1 to: anInteger2 [
	| src dst |
	src := variables realArrayAt: anInteger1.
	dst := variables realArrayAt: anInteger2.
	diffuser nsum4: src dst: dst cols: order rows: order
]

{ #category : #microworld }
SPatches >> nsum8: anInteger1 to: anInteger2 [
	| src dst |
	src := variables realArrayAt: anInteger1.
	dst := variables realArrayAt: anInteger2.
	diffuser nsum8: src dst: dst cols: order rows: order
]

{ #category : #accessing }
SPatches >> order [
	^ order
]

{ #category : #private }
SPatches >> pointOfRow: r col: c [
	^ (r - 1 - (order // 2)) @ (c - 1 - (order // 2))
]

{ #category : #printing }
SPatches >> printOn: aStream [
	aStream
		nextPutAll: 'Patches(';
		nextPutAll: order asString;
		nextPut: $x;
		nextPutAll: order asString;
		nextPut: $).
]

{ #category : #initialization }
SPatches >> reset [
	varId := SPatchVarDef new.
	variables := Variables new updateVarDef: varId.
]

{ #category : #accessing }
SPatches >> rows [
	^ order
]

{ #category : #microworld }
SPatches >> scaleVarNo: vid color: baseColor from: from to: to [
	| v c |
	v := variables realArrayAt: vid.
	c := variables realArrayAt: SPatchVarDef colorVarNo.
	diffuser scale: v dst: c color: baseColor from: from to: to
]

{ #category : #private }
SPatches >> setupCaches [
	halfOrder := (order / 2) asFloat.
	negatedHalfOrder := halfOrder negated.
]

{ #category : #microworld }
SPatches >> size [
	^ order * order
]

{ #category : #'object i/o' }
SPatches >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(order) on: anObjStream.
]

{ #category : #'accessing variable' }
SPatches >> var: anInteger1 at: anInteger2 [
	anInteger1 = varId class xVarNo
		ifTrue: [ ^ self xAt: anInteger2 ].
	anInteger1 = varId class yVarNo
		ifTrue: [ ^ self yAt: anInteger2 ].
	^ super var: anInteger1 at: anInteger2
]

{ #category : #'accessing variable' }
SPatches >> var: anInteger at: id put: aNumber [
	| data |
	data := aNumber.
	anInteger = varId class colorVarNo
		ifTrue: [ data := SColorList default normalize: data ].
	super var: anInteger at: id put: data.
]

{ #category : #'accessing variable' }
SPatches >> xAt: anInteger [
"
0 1 2 3
-2 -1 0 1

 0  1  2  3  4
-2 -1  0  1  2
"
	^ (anInteger - 1 \\ order) - (order // 2)
]

{ #category : #'accessing variable' }
SPatches >> yAt: anInteger [
"
0 1 2 3
-2 -1 0 1

 0  1  2  3  4
-2 -1  0  1  2
"
	^ (anInteger - 1 // order) - (order // 2)
]

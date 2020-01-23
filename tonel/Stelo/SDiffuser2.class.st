Class {
	#name : #SDiffuser2,
	#superclass : #Object,
	#instVars : [
		'extented',
		'order',
		'neighborSize',
		'neighbor'
	],
	#category : #'Stelo-Model'
}

{ #category : #private }
SDiffuser2 >> allocateExtended: anInteger [
	(extented notNil and: [anInteger <= extented size])
		ifTrue: [ ^ self ].
	extented := FloatArray new: anInteger.
]

{ #category : #private }
SDiffuser2 >> clearExtended [
	extented atAllPut: 0.
]

{ #category : #accessing }
SDiffuser2 >> diffuse: anArray order: anInteger1 percent: aNumber neighborSize: anInteger2 [
	self setupDiffuseOrder: anInteger1 neighborSize: anInteger2.
	self diffuse: anArray percent: aNumber.
	self restoreExtended: anArray.
]

{ #category : #private }
SDiffuser2 >> diffuse: anArray percent: aNumber [
	| src dst data use distributes n |
	n := neighbor copyFrom: 1 to: neighborSize.
	0 to: order - 1 do: [ :y | 
		src := self indexOfNormalX: 0 y: y.
		dst := self indexOfExtendedX: 0 y: y.
		order
			timesRepeat: [ data := anArray at: src.
				use := data / 100.0 * aNumber.
				distributes := use / neighborSize.
				extented at: dst incrementBy: data - use.
				n do: [ :each | extented at: each + dst incrementBy: distributes ].
				src := src + 1.
				dst := dst + 1 ] ]
]

{ #category : #private }
SDiffuser2 >> indexOfExtendedX: x y: y [
	^ x + 2 + ((y + 1) * (order + 2))
]

{ #category : #private }
SDiffuser2 >> indexOfNormalX: x y: y [
	^ x + 1 + (y * order)
]

{ #category : #initialization }
SDiffuser2 >> initialize [
	order := 0.
	neighborSize := 0.
]

{ #category : #private }
SDiffuser2 >> nsum: anArray [
	| src dst n sum |
	n := neighbor copyFrom: 1 to: neighborSize.
	0 to: order - 1 do: [ :y | 
		src := self indexOfExtendedX: 0 y: y.
		dst := self indexOfNormalX: 0 y: y.
		order
			timesRepeat: [ sum := n sum: [ :each | extented at: src + each ].
				anArray at: dst put: sum.
				src := src + 1.
				dst := dst + 1 ] ]
]

{ #category : #accessing }
SDiffuser2 >> nsum: anArray1 dst: anArray2 order: anInteger1 neighborSize: anInteger2 [
	self setupNSumSrc: anArray1 order: anInteger1 neighborSize: anInteger2.
	self nsum: anArray2.
]

{ #category : #private }
SDiffuser2 >> privExtended [
	^ extented
]

{ #category : #private }
SDiffuser2 >> privExtended: anArray [
	extented := anArray
]

{ #category : #private }
SDiffuser2 >> privNeighbor [
	^ neighbor
]

{ #category : #private }
SDiffuser2 >> privNeighbor: anArray [
	neighbor := anArray
]

{ #category : #private }
SDiffuser2 >> privNeighborSize [
	^ neighborSize
]

{ #category : #private }
SDiffuser2 >> privNeighborSize: anInteger [
	neighborSize := anInteger
]

{ #category : #private }
SDiffuser2 >> privOrder [
	^ order
]

{ #category : #private }
SDiffuser2 >> privOrder: anInteger [
	order := anInteger
]

{ #category : #private }
SDiffuser2 >> restoreExtended: anArray [
	| src dst |
	0 to: order - 1 do: [ :y | 
		src := self indexOfExtendedX: 0 y: y.
		dst := self indexOfNormalX: 0 y: y.
		order
			timesRepeat: [ anArray at: dst put: (extented at: src).
				src := src + 1.
				dst := dst + 1 ] ].
	src := self indexOfExtendedX: 0 y: -1.
	dst := self indexOfNormalX: 0 y: order - 1.
	order
		timesRepeat: [ anArray at: dst incrementBy: (extented at: src).
			src := src + 1.
			dst := dst + 1 ].
	src := self indexOfExtendedX: 0 y: order.
	dst := self indexOfNormalX: 0 y: 0.
	order
		timesRepeat: [ anArray at: dst incrementBy: (extented at: src).
			src := src + 1.
			dst := dst + 1 ].
	src := self indexOfExtendedX: -1 y: 0.
	dst := self indexOfNormalX: order - 1 y: 0.
	order
		timesRepeat: [ anArray at: dst incrementBy: (extented at: src).
			src := src + order + 2.
			dst := dst + order ].
	src := self indexOfExtendedX: order y: 0.
	dst := self indexOfNormalX: 0 y: 0.
	order
		timesRepeat: [ anArray at: dst incrementBy: (extented at: src).
			src := src + order + 2.
			dst := dst + order ].
	src := self indexOfExtendedX: order y: order.
	dst := self indexOfNormalX: 0 y: 0.
	anArray at: dst incrementBy: (extented at: src).
	src := self indexOfExtendedX: -1 y: -1.
	dst := self indexOfNormalX: order - 1 y: order - 1.
	anArray at: dst incrementBy: (extented at: src).
	src := self indexOfExtendedX: -1 y: order.
	dst := self indexOfNormalX: order - 1 y: 0.
	anArray at: dst incrementBy: (extented at: src).
	src := self indexOfExtendedX: order y: -1.
	dst := self indexOfNormalX: 0 y: order - 1.
	anArray at: dst incrementBy: (extented at: src)
]

{ #category : #private }
SDiffuser2 >> setupBorder [
	| src dst |
	src := self indexOfExtendedX: 0 y: 0.
	dst := self indexOfExtendedX: 0 y: order.
	order
		timesRepeat: [ extented at: dst put: (extented at: src).
			src := src + 1.
			dst := dst + 1 ].
	src := self indexOfExtendedX: 0 y: order - 1.
	dst := self indexOfExtendedX: 0 y: -1.
	order
		timesRepeat: [ extented at: dst put: (extented at: src).
			src := src + 1.
			dst := dst + 1 ].
	src := self indexOfExtendedX: order - 1 y: 0.
	dst := self indexOfExtendedX: -1 y: 0.
	order
		timesRepeat: [ extented at: dst put: (extented at: src).
			src := src + order + 2.
			dst := dst + order + 2 ].
	src := self indexOfExtendedX: 0 y: 0.
	dst := self indexOfExtendedX: order y: 0.
	order
		timesRepeat: [ extented at: dst put: (extented at: src).
			src := src + order + 2.
			dst := dst + order + 2 ].
	src := self indexOfExtendedX: 0 y: 0.
	dst := self indexOfExtendedX: order y: order.
	extented at: dst put: (extented at: src).
	src := self indexOfExtendedX: order - 1 y: order - 1.
	dst := self indexOfExtendedX: -1 y: -1.
	extented at: dst put: (extented at: src).
	src := self indexOfExtendedX: order - 1 y: 0.
	dst := self indexOfExtendedX: -1 y: order.
	extented at: dst put: (extented at: src).
	src := self indexOfExtendedX: 0 y: order - 1.
	dst := self indexOfExtendedX: order y: -1.
	extented at: dst put: (extented at: src)
]

{ #category : #private }
SDiffuser2 >> setupDiffuseOrder: anInteger1 neighborSize: anInteger2 [
	self allocateExtended: (anInteger1 + 2) * (anInteger1 + 2).
	order := anInteger1.
	self setupNeighbor.
	self clearExtended.
	neighborSize := anInteger2.
]

{ #category : #private }
SDiffuser2 >> setupExtended: anArray [
	| src dst |
	src := ReadStream on: anArray.
	dst := WriteStream on: extented.
	order + 2 timesRepeat: [ dst nextPut: 0 ].
	order
		timesRepeat: [ dst nextPut: 0.
			order timesRepeat: [ dst nextPut: src next ].
			dst nextPut: 0 ].
	order + 2 timesRepeat: [ dst nextPut: 0 ]
]

{ #category : #private }
SDiffuser2 >> setupNSumSrc: anArray1 order: anInteger1 neighborSize: anInteger2 [
	| sz |
	sz := (anInteger1 + 2) * (anInteger1 + 2).
	self allocateExtended: sz.
	order := anInteger1.
	self setupNeighbor.
	self setupExtended: anArray1.
	self setupBorder.
	neighborSize := anInteger2.
]

{ #category : #private }
SDiffuser2 >> setupNeighbor [
	neighbor := {1.
	-1.
	(order + 2).
	(order + 2) negated.
	(order + 1).
	(order + 3).
	(order + 1) negated.
	(order + 3) negated}
]

Class {
	#name : #SNativeDiffuser,
	#superclass : #SDiffuser,
	#instVars : [
		'extented',
		'order',
		'neighborSize',
		'neighbor'
	],
	#category : #'Stelo-Model'
}

{ #category : #private }
SNativeDiffuser >> allocateExtended: anInteger [
	(extented notNil and: [anInteger <= extented size])
		ifTrue: [ ^ self clearExtended ].
	extented := FloatArray new: anInteger.
]

{ #category : #private }
SNativeDiffuser >> clearExtended [
	extented atAllPut: 0.
]

{ #category : #api }
SNativeDiffuser >> diffuse4: anArray cols: anInteger rows: anInteger3 percent: aNumber [
	self assert: [ anInteger = anInteger3 ].
	self setupDiffuseOrder: anInteger neighborSize: 4.
	self diffuse: anArray percent: aNumber.
	self restoreExtended: anArray
]

{ #category : #api }
SNativeDiffuser >> diffuse8: anArray cols: anInteger rows: anInteger3 percent: aNumber [
	self assert: [ anInteger = anInteger3 ].
	self setupDiffuseOrder: anInteger neighborSize: 8.
	self diffuse: anArray percent: aNumber.
	self restoreExtended: anArray
]

{ #category : #private }
SNativeDiffuser >> diffuse: anArray percent: aNumber [
	| src dst data use distributes n uses |
	n := neighbor copyFrom: 1 to: neighborSize.
	uses := anArray copy.
	uses /= 100.0.
	uses *= aNumber.
	src := self indexOfNormalX: 0 y: 0.
	dst := self indexOfExtendedX: 0 y: 0.
	order
		timesRepeat: [ order
				timesRepeat: [ data := anArray at: src.
					use := uses at: src.
					distributes := use / neighborSize.
					extented at: dst incrementBy: data - use.
					n
						do: [ :each | extented at: each + dst incrementBy: distributes ].
					src := src + 1.
					dst := dst + 1 ].
			dst := dst + 2 ]
]

{ #category : #accessing }
SNativeDiffuser >> diffuserName [
	^ 'native diffuser'
]

{ #category : #private }
SNativeDiffuser >> indexOfExtendedX: x y: y [
	^ x + 2 + ((y + 1) * (order + 2))
]

{ #category : #private }
SNativeDiffuser >> indexOfNormalX: x y: y [
	^ x + 1 + (y * order)
]

{ #category : #initialization }
SNativeDiffuser >> initialize [
	order := 0.
	neighborSize := 0.
]

{ #category : #testing }
SNativeDiffuser >> isPluginDiffuser [
	^ false
]

{ #category : #api }
SNativeDiffuser >> nsum4: anArray1 dst: anArray2 cols: anInteger3 rows: anInteger4 [
	self assert: [ anInteger3 = anInteger4 ].
	self setupNSumSrc: anArray1 order: anInteger3 neighborSize: 4.
	self nsum: anArray2.
]

{ #category : #api }
SNativeDiffuser >> nsum8: anArray1 dst: anArray2 cols: anInteger3 rows: anInteger4 [
	self assert: [ anInteger3 = anInteger4 ].
	self setupNSumSrc: anArray1 order: anInteger3 neighborSize: 8.
	self nsum: anArray2.
]

{ #category : #private }
SNativeDiffuser >> nsum: anArray [
	| src dst n sum |
	n := neighbor copyFrom: 1 to: neighborSize.
	src := self indexOfExtendedX: 0 y: 0.
	dst := self indexOfNormalX: 0 y: 0.
	order
		timesRepeat: [ order
				timesRepeat: [ sum := n sum: [ :each | extented at: src + each ].
					anArray at: dst put: sum.
					src := src + 1.
					dst := dst + 1 ].
			src := src + 2 ]
]

{ #category : #private }
SNativeDiffuser >> privExtended [
	^ extented
]

{ #category : #private }
SNativeDiffuser >> privExtended: anArray [
	extented := anArray
]

{ #category : #private }
SNativeDiffuser >> privNeighbor [
	^ neighbor
]

{ #category : #private }
SNativeDiffuser >> privNeighbor: anArray [
	neighbor := anArray
]

{ #category : #private }
SNativeDiffuser >> privNeighborSize [
	^ neighborSize
]

{ #category : #private }
SNativeDiffuser >> privNeighborSize: anInteger [
	neighborSize := anInteger
]

{ #category : #private }
SNativeDiffuser >> privOrder [
	^ order
]

{ #category : #private }
SNativeDiffuser >> privOrder: anInteger [
	order := anInteger
]

{ #category : #private }
SNativeDiffuser >> restoreExtended: anArray [
	| src dst |
	src := self indexOfExtendedX: 0 y: 0.
	dst := self indexOfNormalX: 0 y: 0.
	0 to: order - 1 do: [ :y | 
		order
			timesRepeat: [ anArray at: dst put: (extented at: src).
				src := src + 1.
				dst := dst + 1 ].
		src := src + 2 ].
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

{ #category : #api }
SNativeDiffuser >> scale: aFloatArray dst: aByteArray color: baseColor from: anInteger to: anInteger5 [
	| c |
	aFloatArray
		withIndexDo: [ :each :index | 
			c := ColorList
				scaleValue: each
				color: baseColor
				from: anInteger
				to: anInteger5.
			aByteArray at: index put: c ]
]

{ #category : #private }
SNativeDiffuser >> setupBorder [
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
SNativeDiffuser >> setupDiffuseOrder: anInteger1 neighborSize: anInteger2 [
	self allocateExtended: (anInteger1 + 2) * (anInteger1 + 2).
	order := anInteger1.
	self setupNeighbor.
	neighborSize := anInteger2.
]

{ #category : #private }
SNativeDiffuser >> setupExtended: anArray [
	| src dst |
	src := 1.
	dst := order + 4.
	order
		timesRepeat: [ extented
				replaceFrom: dst
				to: dst + order - 1
				with: anArray
				startingAt: src.
			src := src + order.
			dst := dst + order + 2 ]
]

{ #category : #private }
SNativeDiffuser >> setupNSumSrc: anArray1 order: anInteger1 neighborSize: anInteger2 [
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
SNativeDiffuser >> setupNeighbor [
	neighbor := {1.
	-1.
	(order + 2).
	(order + 2) negated.
	(order + 1).
	(order + 3).
	(order + 1) negated.
	(order + 3) negated}
]

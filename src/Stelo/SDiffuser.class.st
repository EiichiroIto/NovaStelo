Class {
	#name : #SDiffuser,
	#superclass : #Object,
	#instVars : [
		'src',
		'dst',
		'rows',
		'cols',
		'neighbor',
		'indexesDict',
		'cornerIndexes',
		'setupSelector'
	],
	#category : #'Stelo-Model'
}

{ #category : #'instance creation' }
SDiffuser class >> neighbor4 [
	^ self basicNew
		setupSelector: #setupNeighbor4;
		yourself.
]

{ #category : #'instance creation' }
SDiffuser class >> neighbor8 [
	^ self basicNew
		setupSelector: #setupNeighbor8;
		yourself.
]

{ #category : #'instance creation' }
SDiffuser class >> new [
	self shouldNotImplement.
]

{ #category : #private }
SDiffuser >> borders [
	^ #(top left right bottom)
]

{ #category : #private }
SDiffuser >> corners [
	^ #(topLeft topRight bottomLeft bottomRight)
]

{ #category : #accessing }
SDiffuser >> diffuse: anInteger array: anArray [
	self privSrc: anArray.
	self diffuseInner: anInteger.
	self borders do: [ :each | self diffuseBorder: anInteger at: each ].
	self corners do: [ :each | self diffuseCorner: anInteger at: each ].
	^ dst
]

{ #category : #private }
SDiffuser >> diffuseBorder: anInteger at: aSymbol [
	| srcIndex dstIndex data use distributes size list |
	list := indexesDict at: aSymbol.
	size := neighbor size.
	rows + 2 to: list size - rows - 1 do: [ :i | 
		srcIndex := list at: i.
		data := src at: srcIndex.
		use := data / 100.0 * anInteger.
		distributes := use / size.
		dst at: srcIndex put: (dst at: srcIndex) + data - use.
		neighbor + i
			do: [ :i2 | 
				dstIndex := list at: i2.
				dst at: dstIndex put: (dst at: dstIndex) + distributes ] ].
]

{ #category : #private }
SDiffuser >> diffuseCorner: anInteger at: aSymbol [
	| index data use distributes list |
	list := indexesDict at: aSymbol.
	index := list at: 5.
	data := src at: index.
	use := data / 100.0 * anInteger.
	distributes := use / cornerIndexes size.
	dst at: index put: (dst at: index) + data - use.
	cornerIndexes
		do: [ :i | 
			index := list at: i.
			dst at: index put: (dst at: index) + distributes ].
]

{ #category : #private }
SDiffuser >> diffuseInner: anInteger [
	| use distributes size data |
	size := neighbor size.
	(indexesDict at: #inner)
		do: [ :index | 
			data := src at: index.
			use := data / 100.0 * anInteger.
			distributes := use / size.
			dst at: index put: ((dst at: index) + data - use).
			neighbor + index
				do: [ :dstIndex | dst at: dstIndex put: ((dst at: dstIndex) + distributes) ] ].
]

{ #category : #accessing }
SDiffuser >> nsum: anArray [
	self privSrc: anArray.
	self nsumInner.
	self borders do: [ :each | self nsumBorderAt: each ].
	self corners do: [ :each | self nsumCornerAt: each ].
	^ dst
]

{ #category : #private }
SDiffuser >> nsumBorderAt: aSymbol [
	| list index index2 sum |
	list := indexesDict at: aSymbol.
	rows + 2 to: list size - rows - 1 do: [ :i | 
		index := list at: i.
		sum := neighbor + i
			sum: [ :i2 | 
				index2 := list at: i2.
				src at: index2 ].
		dst at: index put: sum ].
]

{ #category : #private }
SDiffuser >> nsumCornerAt: aSymbol [
	| list index sum |
	list := indexesDict at: aSymbol.
	sum := cornerIndexes
		sum: [ :i | 
			index := list at: i.
			src at: index ].
	index := list at: 5.
	dst at: index put: sum.
]

{ #category : #private }
SDiffuser >> nsumInner [
	| list sum |
	list := indexesDict at: #inner.
	list
		do: [ :index | 
			sum := neighbor + index sum: [ :i | src at: i ].
			dst at: index put: sum ].
]

{ #category : #private }
SDiffuser >> privCols [
	^ cols
]

{ #category : #private }
SDiffuser >> privCornerIndexes [
	^ cornerIndexes
]

{ #category : #private }
SDiffuser >> privDst: aFloatArray [
	dst := aFloatArray.
]

{ #category : #private }
SDiffuser >> privIndexesDict [
	^ indexesDict
]

{ #category : #private }
SDiffuser >> privNeighbor [
	^ neighbor
]

{ #category : #private }
SDiffuser >> privRows [
	^ rows
]

{ #category : #private }
SDiffuser >> privSrc [
	^ src
]

{ #category : #private }
SDiffuser >> privSrc: aFloatArray [
	src := aFloatArray.
	dst := FloatArray new: src size.
]

{ #category : #accessing }
SDiffuser >> result [
	^ dst
]

{ #category : #accessing }
SDiffuser >> rows: anInteger1 cols: anInteger2 [
	rows := anInteger1.
	cols := anInteger2.
	self setupIndexes.
	self perform: setupSelector.
]

{ #category : #private }
SDiffuser >> setupIndexes [
	| dict left right index inner tleft tright bleft bright top bottom |
	dict := Dictionary new.
	tleft := 1.
	tright := rows.
	top := (1 to: rows) asArray.
	left := OrderedCollection new.
	inner := OrderedCollection new.
	right := OrderedCollection new.
	index := rows.
	left add: 1.
	right add: rows.
	cols - 2
		timesRepeat: [ left add: index + 1.
			inner addAll: (index + 2 to: index + rows - 1).
			right add: index + rows.
			index := index + rows ].
	left add: index + 1.
	right add: index + rows.
	bleft := index + 1.
	bottom := (index + 1 to: index + rows) asArray.
	bright := index + rows.
	dict at: #inner put: inner asArray.
	dict at: #top put: bottom , top , (top collect: [ :each | each + rows ]).
	dict at: #bottom put: (bottom collect: [ :each | each - rows ]) , bottom , top.
	dict at: #left put: (right , left , (left collect: [ :each | each + 1 ])) asArray.
	dict at: #right put: ((right collect: [ :each | each - 1 ]) , right , left) asArray.
	dict
		at: #topLeft
		put:
			{bright.
			bleft.
			(bleft + 1).
			tright.
			tleft.
			(tleft + 1).
			tright + rows.
			rows + 1.
			(rows + 2).}.
	dict
		at: #topRight
		put:
			{(bright - 1).
			bright.
			bleft.
			(tright - 1).
			tright.
			tleft.
			(tright + rows - 1).
			(tright + rows).
			(tleft + rows).}.
	dict
		at: #bottomLeft
		put:
			{(bright - rows).
			(bleft - rows).
			(bleft - rows + 1).
			bright.
			bleft.
			(bleft + 1).
			tright.
			tleft.
			(tleft + 1).}.
	dict
		at: #bottomRight
		put:
			{(bright - rows - 1).
			(bright - rows).
			(bleft - rows).
			(bright - 1).
			bright.
			bleft.
			(tright - 1).
			tright.
			tleft.}.
	indexesDict := dict.
]

{ #category : #private }
SDiffuser >> setupNeighbor4 [
	| list |
	list := OrderedCollection new.
	list add: 1.
	list add: -1.
	list add: rows negated.
	list add: rows.
	neighbor := list asArray.
	cornerIndexes := #(2 4 6 8).
]

{ #category : #private }
SDiffuser >> setupNeighbor8 [
	| list |
	list := OrderedCollection new.
	list add: 1.
	list add: -1.
	list add: rows negated - 1.
	list add: rows negated.
	list add: rows negated + 1.
	list add: rows - 1.
	list add: rows.
	list add: rows + 1.
	neighbor := list asArray.
	cornerIndexes := #(1 2 3 4 6 7 8 9).
]

{ #category : #private }
SDiffuser >> setupSelector [
	^ setupSelector
]

{ #category : #private }
SDiffuser >> setupSelector: aSymbol [
	setupSelector := aSymbol.
]

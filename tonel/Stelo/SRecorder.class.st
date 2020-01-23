Class {
	#name : #SRecorder,
	#superclass : #Object,
	#instVars : [
		'writer',
		'rate',
		'count',
		'microworld',
		'modelExtent',
		'cell',
		'offset',
		'extent'
	],
	#category : #'Stelo-Morphic'
}

{ #category : #private }
SRecorder >> cell [
	^ cell
]

{ #category : #accessing }
SRecorder >> close [
	writer ifNil: [ ^ self ].
	writer close.
	writer := nil.
]

{ #category : #private }
SRecorder >> defaultFrameDelay [
	^ 10
]

{ #category : #accessing }
SRecorder >> extent [
	^ extent
]

{ #category : #accessing }
SRecorder >> extent: aPoint [
	extent := aPoint.
]

{ #category : #initialization }
SRecorder >> initialize [
	super initialize.
	rate := 1.
	count := 0.
]

{ #category : #testing }
SRecorder >> isOpen [
	^ writer notNil
]

{ #category : #private }
SRecorder >> makeForm [
	| form x0 x y colors index tc frame |
	self modelChanged
		ifTrue: [ self updateCache ].
	form := ColorForm extent: extent depth: 32.
	frame := AnimatedImageFrame new
		delay: self defaultFrameDelay;
		form: form.
	colors := microworld colors.
	x0 := offset x.
	y := offset y + (cell y * (modelExtent y - 1)).
	index := 1.
	modelExtent y
		timesRepeat: [ x := x0.
			modelExtent x
				timesRepeat: [ tc := SColorList colorAt: (colors at: index).
					form fill: (x @ y extent: cell) fillColor: tc.
					index := index + 1.
					x := x + cell x ].
			y := y - cell y ].
	^ frame
]

{ #category : #private }
SRecorder >> modelChanged [
	^ modelExtent ~= microworld extent
]

{ #category : #private }
SRecorder >> offset [
	^ offset
]

{ #category : #accessing }
SRecorder >> openFileNamed: aString [
	self close.
	writer := GIFReadWriter on: aString asFileReference binaryWriteStream.
	writer ifNil: [ ^ self ].
	count := 0.
]

{ #category : #accessing }
SRecorder >> rate: anInteger [
	rate := anInteger.
	count := 0.
]

{ #category : #accessing }
SRecorder >> sworld: aMicroWorld [
	microworld := aMicroWorld.
]

{ #category : #private }
SRecorder >> updateCache [
	modelExtent := microworld extent.
	cell := self extent // modelExtent.
	offset := (self extent - (modelExtent * cell)) // 2.
]

{ #category : #accessing }
SRecorder >> writeForced: aBoolean [
	self isOpen
		ifFalse: [ ^ self ].
	count := count + 1.
	(aBoolean or: [ count >= rate ])
		ifFalse: [ ^ self ].
	writer nextPutFrame: self makeForm.
	count := 0.
]

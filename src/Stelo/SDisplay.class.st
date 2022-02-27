Class {
	#name : #SDisplay,
	#superclass : #Morph,
	#instVars : [
		'modelExtent',
		'cell',
		'offset',
		'forceModelChanged',
		'sworld',
		'info',
		'stepTime',
		'whenStepsDo',
		'whenClickDo',
		'isGrayscale'
	],
	#category : #'Stelo-Morphic'
}

{ #category : #'instance creation' }
SDisplay class >> sworld: aWorld [
	^ self basicNew
		initialize;
		sworld: aWorld;
		yourself.
]

{ #category : #private }
SDisplay >> cell [
	^ cell
]

{ #category : #private }
SDisplay >> cell: aPoint [
	cell := aPoint
]

{ #category : #'event handling' }
SDisplay >> click: evt [
	| p |
	p := evt cursorPoint - self topLeft.
	p := self pointOf: p.
	whenClickDo ifNotNil: [ whenClickDo cull: p ]
]

{ #category : #private }
SDisplay >> defaultExtent [
	^ 220 @ 220
]

{ #category : #drawing }
SDisplay >> drawInfoOn: aCanvas [
	info ifNil: [ ^ self ].
	aCanvas
		drawString: info
		at: self topLeft + offset + (5 @ 5)
		font: nil
		color: self borderColor
]

{ #category : #drawing }
SDisplay >> drawOn: aCanvas [
	super drawOn: aCanvas.
	sworld ifNil: [ ^ aCanvas frameRectangle: self bounds color: Color red ].
	self modelChanged
		ifTrue: [ self updateCache ].
	self extent < modelExtent
		ifTrue: [ ^ self ].
	self drawWorldOn: aCanvas.
	self drawInfoOn: aCanvas.
]

{ #category : #drawing }
SDisplay >> drawWorldOn: aCanvas [
	| x0 x y colors index block |
	block := isGrayscale
		ifTrue: [ [ :each | Color gray: each / 255.0 ] ]
		ifFalse: [ [ :each | SColorList default realColorAt: each ] ].
	colors := sworld colors asArray collect: block.
	x0 := self left + offset x.
	y := self top + offset y + (cell y * (modelExtent y - 1)).
	index := 1.
	modelExtent y
		timesRepeat: [ x := x0.
			modelExtent x
				timesRepeat: [ aCanvas
						fillRectangle: (x @ y extent: cell)
						color: (colors at: index).
					index := index + 1.
					x := x + cell x ].
			y := y - cell y ]
]

{ #category : #geometry }
SDisplay >> extent: aPoint [
	super extent: aPoint.
	forceModelChanged := true.
]

{ #category : #testing }
SDisplay >> forceModelChanged [
	^ forceModelChanged
]

{ #category : #'event handling' }
SDisplay >> handlesMouseDown: evt [
	^ true
]

{ #category : #accessing }
SDisplay >> info [
	^ info
]

{ #category : #accessing }
SDisplay >> info: aString [
	info := aString.
]

{ #category : #initialization }
SDisplay >> initialize [
	super initialize.
	self extent: self defaultExtent.
	self color: self theme backgroundColor.
	self borderColor: self theme textColor.
	forceModelChanged := true.
	info := ''.
	isGrayscale := false.
	self stepTime: 1000
]

{ #category : #accessing }
SDisplay >> isGrayscale [
	^ isGrayscale
]

{ #category : #accessing }
SDisplay >> isGrayscale: aBoolean [
	isGrayscale := aBoolean
]

{ #category : #accessing }
SDisplay >> modelBounds [
	offset ifNil: [ ^ self bounds ].
	^ self topLeft + offset extent: modelExtent * cell
]

{ #category : #testing }
SDisplay >> modelChanged [
	^ forceModelChanged or: [ modelExtent ~= sworld extent ]
]

{ #category : #accessing }
SDisplay >> modelExtent [
	^ modelExtent
]

{ #category : #accessing }
SDisplay >> modelExtent: aPoint [
	modelExtent := aPoint
]

{ #category : #'event handling' }
SDisplay >> mouseDown: evt [
	evt hand newKeyboardFocus: nil.
	evt hand waitForClicksOrDrag: self event: evt
]

{ #category : #private }
SDisplay >> offset [
	^ offset
]

{ #category : #private }
SDisplay >> offset: aPoint [
	offset := aPoint
]

{ #category : #private }
SDisplay >> pointOf: aPoint [
	| p |
	p := (aPoint - offset) // cell - (modelExtent // 2) + (0 @ 1).
	^ p x @ p y negated
]

{ #category : #'stepping and presenter' }
SDisplay >> step [
	whenStepsDo ifNotNil: [ whenStepsDo value ]
]

{ #category : #accessing }
SDisplay >> stepTime [
	^ stepTime
]

{ #category : #accessing }
SDisplay >> stepTime: anInteger [
	stepTime := anInteger
]

{ #category : #accessing }
SDisplay >> sworld [
	^ sworld
]

{ #category : #accessing }
SDisplay >> sworld: aWorld [
	sworld := aWorld.
]

{ #category : #accessing }
SDisplay >> toggleGrayscale [
	isGrayscale := isGrayscale not.
	self changed
]

{ #category : #private }
SDisplay >> updateCache [
	forceModelChanged := false.
	modelExtent := sworld extent.
	cell := self extent // modelExtent.
	cell := 1 @ 1 * cell min.
	offset := (self extent - (modelExtent * cell)) // 2
]

{ #category : #'stepping and presenter' }
SDisplay >> wantsSteps [
	^ true
]

{ #category : #accessing }
SDisplay >> whenClickDo [
	^ whenClickDo
]

{ #category : #accessing }
SDisplay >> whenClickDo: aBlock [
	whenClickDo := aBlock
]

{ #category : #accessing }
SDisplay >> whenStepsDo [
	^ whenStepsDo
]

{ #category : #accessing }
SDisplay >> whenStepsDo: aBlock [
	whenStepsDo := aBlock
]

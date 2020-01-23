Class {
	#name : #ReporterBlockMorph,
	#superclass : #CommandBlockMorph,
	#instVars : [
		'isBoolean'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #other }
ReporterBlockMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the given type. Answer false by default."

	aBlockMorph isReporter ifFalse: [^ false].
	^ aBlockMorph isBooleanReporter = self isBooleanReporter

]

{ #category : #'code generation' }
ReporterBlockMorph >> argString: aGenerator [
	^ aGenerator reporterArgString: self.
]

{ #category : #watcher }
ReporterBlockMorph >> canBecomeWatcher [
	^ self isReporter
		and: [ self argumentCount <= 1
				and:
					[ self script watcherSelectors includes: selector ] ]
]

{ #category : #other }
ReporterBlockMorph >> computeHighlightColors [

	| h s v |
	h := color hue.
	s := color saturation.
	v := color brightness.
	highlightColor1 := Color h: h s: (s - 0.13) v: (v + 0.17).
	highlightColor2 := Color h: h s: s v: (v + 0.06).
	shadowColor := color mixed: 0.8 with: Color black.

]

{ #category : #drawing }
ReporterBlockMorph >> drawBooleanOn: aCanvas [ 

	| right topY bottomY xInset c |
	self computeHighlightColors.

	right := self width.
	topY := bottomY := self height // 2.
	self height even ifTrue: [topY := bottomY - 1].
	xInset := 0.
	[topY >= 0] whileTrue: [
		topY = 0 ifTrue: [c := highlightColor1].
		topY = 1 ifTrue: [c := highlightColor2].
		topY > 1 ifTrue: [c := color].
		self drawHLineFrom: xInset to: right - xInset y: topY color: c on: aCanvas.
		(topY > 1) & (xInset > 0) ifTrue: [
			self drawPoint: xInset@topY color: highlightColor1 on: aCanvas.
			self drawPoint: (right - xInset - 1)@topY color: shadowColor on: aCanvas].

		c := bottomY = (self height - 1) ifTrue: [shadowColor] ifFalse: [color].
		self drawHLineFrom: xInset to: right - xInset y: bottomY color: c on: aCanvas.
		xInset > 0 ifTrue: [
			self drawPoint: xInset@bottomY color: shadowColor on: aCanvas.
			self drawPoint: (right - xInset - 1)@bottomY color: shadowColor on: aCanvas].

		xInset := xInset + 1.	
		bottomY := bottomY + 1.
		topY := topY - 1].


]

{ #category : #drawing }
ReporterBlockMorph >> drawNumericOn: aCanvas [ 

	| right topY bottomY radius xInset c |
	self computeHighlightColors.

	right := self width.
	topY := bottomY := radius := self height // 2.
	self height even ifTrue: [topY := bottomY - 1].
	[topY >= 0] whileTrue: [
		xInset := radius - (radius squared - (radius - topY - 1) squared) sqrt rounded.

		topY = 0 ifTrue: [c := highlightColor1].
		topY = 1 ifTrue: [c := highlightColor2].
		topY > 1 ifTrue: [c := color].
		self drawHLineFrom: xInset to: right - xInset y: topY color: c on: aCanvas.
		(xInset > 0) & (topY > 1) ifTrue: [
			self drawPoint: xInset@topY color: highlightColor1 on: aCanvas.
			self drawPoint: (right - xInset - 1)@topY color: highlightColor1 on: aCanvas].

		c := bottomY = (self height - 1) ifTrue: [shadowColor] ifFalse: [color].
		self drawHLineFrom: xInset to: right - xInset y: bottomY color: c on: aCanvas.
		xInset > 0 ifTrue: [
			self drawPoint: xInset@bottomY color: shadowColor on: aCanvas.
			self drawPoint: (right - xInset - 1)@bottomY color: shadowColor on: aCanvas].

		bottomY := bottomY + 1.
		topY := topY - 1].

]

{ #category : #drawing }
ReporterBlockMorph >> drawOn: aCanvas [ 

	self computeHighlightColors.
	isBoolean
		ifTrue: [self drawBooleanOn: aCanvas]
		ifFalse: [self drawNumericOn: aCanvas].

]

{ #category : #'object i/o' }
ReporterBlockMorph >> fieldsVersion [

	^ 2

]

{ #category : #other }
ReporterBlockMorph >> fixBlockLayout [
	"Update the positions of my submorphs."

	| mList maxH h x y |
	blockLayoutNeeded ifFalse: [^ self].
	cachedForm := nil.
	cachedFeedbackForm := nil.

	mList := self nonControlFlowSubmorphs.
	maxH := 0.
	mList do: [:m |
		(m isKindOf: ArgMorph) ifTrue: [m fixArgLayout].
		(m isKindOf: BlockMorph) ifTrue: [m fixBlockLayout].
		maxH := maxH max: m height].
	h := (maxH + 4) max: 17.

	x := isBoolean ifTrue: [8] ifFalse: [4].
	(mList size > 0 and: [mList first isKindOf: StringMorph]) ifTrue: [x := x + 2].

	mList do: [:m |
		(m isKindOf: StringMorph) ifTrue: [m color: self labelColor].
		y := (h - m height) // 2.
		m position: self position + (x@y).
		x := x + m width + 3].
	x := x + (isBoolean ifTrue: [1] ifFalse: [-3]).

	self extent: (x + 4) @ h.
	(self meOrOwnerThatIsA: ScratchBlockPaletteMorph) ifNotNil: [
		(self meOrOwnerThatIsA: ScratchBlockPaletteMorph) fixLayout].

]

{ #category : #watcher }
ReporterBlockMorph >> getAssociatedSprite [
	"Return my receiver."

	^ receiver

]

{ #category : #'object i/o' }
ReporterBlockMorph >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	classVersion = 1 ifTrue: [^ self].

	"fields added in version 2"
	self initFieldsNamed: #(
		isBoolean
	) from: anObjStream.


]

{ #category : #initialization }
ReporterBlockMorph >> initialize [

	super initialize.
	isBoolean := false.
	self extent: 80@20.

]

{ #category : #other }
ReporterBlockMorph >> isBoolean: aBoolean [

	isBoolean := aBoolean.

]

{ #category : #other }
ReporterBlockMorph >> isBooleanReporter [

	^ isBoolean

]

{ #category : #other }
ReporterBlockMorph >> isReporter [
	"Answer true if this block reports a value."

	^ true

]

{ #category : #'object i/o' }
ReporterBlockMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		isBoolean
	) on: anObjStream.

]

{ #category : #processes }
ReporterBlockMorph >> toggleProcess [
	"do nothing"
]

"
I represent a script consisting of a sequence of blocks.


"
Class {
	#name : #HatBlockMorph,
	#superclass : #BlockMorph,
	#instVars : [
		'scriptNameMorph',
		'indicatorMorph',
		'scriptOwner',
		'parameters',
		'isClickable'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #private }
HatBlockMorph >> blockAttachPoints: aSet [
	"Answer a collection of possible attachment points for me. Each entry is an Association mapping a point to the morph to which a dropping block could be attached."

	| nextB |
	nextB := self nextBlock.
	nextB
		ifNil: [ aSet add: self bottomLeft -> self ]
		ifNotNil: [ nextB blockAttachPoints: aSet ]
]

{ #category : #drawing }
HatBlockMorph >> drawArchOn: aCanvas [ 

	| archForm stretchX leftForm midForm rightForm y x |
	archForm := self hatTopForm.
	stretchX := archForm width - 22.
	leftForm := archForm copy: (0@0 corner: stretchX@archForm height).
	midForm := archForm copy: (stretchX@0 extent: 1@archForm height).
	rightForm := archForm copy: ((stretchX + 1)@0 corner: archForm extent).
	
	y := self top.
	x := self left.
	aCanvas paintImage: leftForm at: x@y.
	x := x + leftForm width.
	(self width - (leftForm width + rightForm width)) asInteger timesRepeat: [
		aCanvas paintImage: midForm at: x@y.
		x := x + 1].
	aCanvas paintImage: rightForm at: x@y.

]

{ #category : #drawing }
HatBlockMorph >> drawBodyOn: aCanvas [ 

	| archBottom |
	archBottom := self top + self hatTopForm height.

	self drawArchOn: aCanvas.
	aCanvas
		fillRectangle: (self left@archBottom corner: (self right - 1)@(self bottom - 7))
		color: color.
	aCanvas
		fillRectangle: (self left@archBottom corner: (self left + 2)@(self bottom - 7))
		color: highlightColor2.

	aCanvas
		fillRectangle: ((self right - 1)@(archBottom -  1) corner: self right@(self bottom - 7))
		color: shadowColor.

]

{ #category : #drawing }
HatBlockMorph >> drawOn: aCanvas [ 

	| c |
	self computeHighlightColors.
	c := FormCanvas extent: self extent depth: 32.
	c := c copyOffset: self topLeft negated.
	self drawBodyOn: c.
	self drawBottomEdgeOn: c.

	self drawFinalOn: aCanvas fromCanvas: c.

]

{ #category : #'event handling' }
HatBlockMorph >> duplicate [
	"Overridden to pick an unused script name for the duplicate."

	| m |
	m := self fullCopy.
	scriptOwner ifNotNil: [m scriptOwner: scriptOwner].
	self world activeHand attachMorph: m.

]

{ #category : #'code generation' }
HatBlockMorph >> emitCode: aGenerator indent: indent [
	aGenerator emitHatBlock: self indent: indent.
]

{ #category : #'object i/o' }
HatBlockMorph >> fieldsVersion [

	^ 1

]

{ #category : #private }
HatBlockMorph >> fixBlockLayout [
	"Update the positions of my submorphs."

	| x centerY nextB nonBlockSubmorphs oldExtent oldPos |
	blockLayoutNeeded
		ifFalse: [ ^ self ].
	super fixBlockLayout.
	oldExtent := self extent.
	oldPos := self position.
	x := self left + 8.
	centerY := self top + 25.
	self nonControlFlowSubmorphs
		do: [ :m | 
			m isArgMorph
				ifTrue: [ m fixArgLayout ].
			m position: x @ (centerY - (m height // 2)).
			x := x + m width + 5 ].
	x + x + 4.
	self width: (x - self left max: self hatTopForm width).
	nonBlockSubmorphs := self submorphs
		select: [ :m | m isBlockMorph not or: [ m isArgMorph ] ].
	self
		height:
			self hatTopForm height
				+
					(nonBlockSubmorphs
						inject: CBlockBracketThickness
						into: [ :h :m | h max: m height + 8 ]).
	(nextB := self nextBlock)
		ifNotNil: [ nextB left: self left.
			nextB top: self bottom - 4.
			nextB fixBlockLayout ]
]

{ #category : #private }
HatBlockMorph >> hatTopForm [

	^ ScratchTheme formAt: #hatBlockTop

]

{ #category : #'object i/o' }
HatBlockMorph >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		scriptNameMorph
		indicatorMorph
		scriptOwner
		parameters
		isClickable
	) from: anObjStream.
	parameters := nil.  "procedures with parameters are no longer supported"

	"remove the indicator morph when reading in an older project"
	indicatorMorph ifNotNil: [
		submorphs := submorphs copyWithout: indicatorMorph.
		indicatorMorph := nil].

]

{ #category : #initialization }
HatBlockMorph >> initialize [

	super initialize.
	self color: (Color h: 41 s: 0.85 v: 0.9).
	self extent: 92@38.
	scriptOwner := nil.

	scriptNameMorph := StringMorph new
		contents: 'script';
		font: (ScratchTheme labelFont);
		color: Color white.
	self addMorph: scriptNameMorph.

]

{ #category : #accessing }
HatBlockMorph >> isHatBlock [

	^ true

]

{ #category : #private }
HatBlockMorph >> mapReceiver: oldObj to: newObj [
	"Used in cloning or importing to make blocks that refererred to the original object new refer to the new copy."

	scriptOwner == oldObj ifTrue: [scriptOwner := newObj].

]

{ #category : #private }
HatBlockMorph >> printHatNameOn: aStream [
	"Append a human-readable string for this hat block's name to the given stream."

	aStream nextPutAll: 'to ', scriptNameMorph contents; cr.


]

{ #category : #accessing }
HatBlockMorph >> receiver [

	^ scriptOwner

]

{ #category : #accessing }
HatBlockMorph >> scriptOwner [

	^ scriptOwner

]

{ #category : #accessing }
HatBlockMorph >> scriptOwner: anObject [

	scriptOwner := anObject.
	self fixBlockLayout.

]

{ #category : #processes }
HatBlockMorph >> start [
	self stop.
	scriptOwner ifNil: [ ^ self ].
	self applicationDo: [ :app | app startProcessFor: self ].
	self changed
]

{ #category : #'object i/o' }
HatBlockMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		scriptNameMorph
		indicatorMorph
		scriptOwner
		parameters
		isClickable
	) on: anObjStream.

]

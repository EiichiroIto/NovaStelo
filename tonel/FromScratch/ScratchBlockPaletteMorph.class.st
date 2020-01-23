"
I am used as a scrollable blocks palette morph in a ScratchViewerMorph.

"
Class {
	#name : #ScratchBlockPaletteMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'project',
		'isForScript'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #other }
ScratchBlockPaletteMorph >> fixLayout [
	"Right align the blocks in the palette if RTL is set to true. The watcher toggle checkbox buttons are assumed to be about 18 pixels wide."

	| offset r |
	owner ifNil: [ ^ self ].
	offset := self topLeft negated.
	r := 0 @ 0 extent: 1 @ 1.
	self
		submorphsDo:
			[ :m | r := r quickMerge: (m fullBounds translateBy: offset) truncated ].
	self width: (r width max: owner width)
]

{ #category : #initialization }
ScratchBlockPaletteMorph >> initialize [
	super initialize.
	borderWidth := 0.
	isForScript := false
]

{ #category : #testing }
ScratchBlockPaletteMorph >> isBlockPalette [
	^ true
]

{ #category : #testing }
ScratchBlockPaletteMorph >> isForScript [
	^ isForScript
]

{ #category : #testing }
ScratchBlockPaletteMorph >> isForScript: aBoolean [
	isForScript := aBoolean
]

{ #category : #'dropping/grabbing' }
ScratchBlockPaletteMorph >> isPartsBin [

	^ true

]

{ #category : #acessing }
ScratchBlockPaletteMorph >> project [
	^ project
]

{ #category : #acessing }
ScratchBlockPaletteMorph >> project: aProject [
	project := aProject
]

{ #category : #'dropping/grabbing' }
ScratchBlockPaletteMorph >> rootForGrabOf: aMorph [
	"I act like a parts bin; answer a new copy of the morph being extracted."

	| root |
	root := aMorph.
	(root isKindOf: BlockMorph) ifFalse: [^ nil].
	[root = self] whileFalse: [
		root owner == self ifTrue: [^ root fullCopy].
		root := root owner].

	^ super rootForGrabOf: aMorph

]

{ #category : #'dropping/grabbing' }
ScratchBlockPaletteMorph >> wantsDroppedMorph: aMorph event: evt [
	^ aMorph isBlockMorph
]

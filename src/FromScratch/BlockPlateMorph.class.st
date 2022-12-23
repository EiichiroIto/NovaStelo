Class {
	#name : #BlockPlateMorph,
	#superclass : #PasteUpMorph,
	#instVars : [
		'draggingPoint',
		'scrollPoint',
		'project'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #'event handling' }
BlockPlateMorph >> handlesMouseWheel: anEvent [

	^ true
]

{ #category : #initialization }
BlockPlateMorph >> initialize [

	super initialize.
	borderWidth := 0
]

{ #category : #'event handling' }
BlockPlateMorph >> mouseDown: evt [

	evt hand newKeyboardFocus: nil.
	evt hand waitForClicksOrDrag: self event: evt
]

{ #category : #'event handling' }
BlockPlateMorph >> mouseMove: evt [

	| range diff newPoint |
	draggingPoint ifNil: [ ^ self ].
	range := self extent - owner extent.
	diff := draggingPoint - evt cursorPoint.
	newPoint := scrollPoint + diff.
	newPoint := newPoint max: 0 @ 0.
	newPoint := newPoint min: range.
	owner
		hScrollPixels: newPoint x;
		vScrollPixels: newPoint y
]

{ #category : #'event handling' }
BlockPlateMorph >> mouseUp: evt [

	draggingPoint := nil.
	evt hand showTemporaryCursor: nil
]

{ #category : #'event handling' }
BlockPlateMorph >> mouseWheel: event [

	| v |
	v := owner vScrollPixels.
	event isUp ifTrue: [ owner vScrollPixels: v - 5 ].
	event isDown ifTrue: [ owner vScrollPixels: v + 5 ]
]

{ #category : #acessing }
BlockPlateMorph >> project [

	^ project
]

{ #category : #acessing }
BlockPlateMorph >> project: aProject [

	project := aProject
]

{ #category : #'event handling' }
BlockPlateMorph >> startDrag: evt [

	draggingPoint := evt cursorPoint.
	scrollPoint := owner hScrollPixels @ owner vScrollPixels.
	evt hand showTemporaryCursor: Cursor move
]

{ #category : #'dropping/grabbing' }
BlockPlateMorph >> wantsDroppedMorph: aMorph event: evt [

	^ aMorph isBlockMorph
]

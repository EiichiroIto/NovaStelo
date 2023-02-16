Class {
	#name : #BlockPlateMorph,
	#superclass : #PasteUpMorph,
	#instVars : [
		'draggingPoint',
		'scrollPoint',
		'project',
		'screenshooting'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #accessing }
BlockPlateMorph >> draggingPoint [

	^ draggingPoint
]

{ #category : #accessing }
BlockPlateMorph >> draggingPoint: anObject [

	draggingPoint := anObject
]

{ #category : #'event handling' }
BlockPlateMorph >> handlesMouseWheel: anEvent [

	^ true
]

{ #category : #initialization }
BlockPlateMorph >> initialize [

	super initialize.
	borderWidth := 0.
	screenshooting := false
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

{ #category : #accessing }
BlockPlateMorph >> project [

	^ project
]

{ #category : #accessing }
BlockPlateMorph >> project: aProject [

	project := aProject
]

{ #category : #accessing }
BlockPlateMorph >> screenshooting [

	^ screenshooting
]

{ #category : #accessing }
BlockPlateMorph >> screenshooting: anObject [

	^ screenshooting := anObject
]

{ #category : #api }
BlockPlateMorph >> screenshot [

	"answer a Form of myself apt for exporting"

	| saveForm leftX topY rightX bottomY |
	submorphs isEmpty ifTrue: [ ^ nil ].
	screenshooting := true.
	self changed.
	saveForm := self imageForm.
	"clip"
	leftX := submorphs anyOne left.
	topY := submorphs anyOne top.
	rightX := submorphs anyOne right.
	bottomY := submorphs anyOne bottom.
	(self allMorphs select: [ :m | m ~= self ]) do: [ :m | 
		leftX := leftX min: m left.
		topY := topY min: m top.
		rightX := rightX max: m right.
		bottomY := bottomY max: m bottom ].
	saveForm := saveForm copy: (leftX @ topY - self position rectangle:
			             rightX @ bottomY - self position).
	screenshooting := false.
	self changed.
	^ saveForm
]

{ #category : #accessing }
BlockPlateMorph >> scrollPoint [

	^ scrollPoint
]

{ #category : #accessing }
BlockPlateMorph >> scrollPoint: anObject [

	scrollPoint := anObject
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

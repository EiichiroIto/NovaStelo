"
I hold the scripts and partially assembled scripts for a ScriptableScratchMorph.

"
Class {
	#name : #ScratchScriptsMorph,
	#superclass : #PasteUpMorph,
	#instVars : [
		'feedbackMorph',
		'screenshooting',
		'project'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #'event handling' }
ScratchScriptsMorph >> cleanUp [
	"Align all scripts vertically in alphabetical order"

	| sortedBlocks y collectedBlocks |
	collectedBlocks := OrderedCollection new.
	submorphs
		do: [ :m | 
			m isBlockMorph
				ifTrue: [ collectedBlocks add: m ] ].
	sortedBlocks := collectedBlocks copy
		sort: [ :s1 :s2 | s1 top < s2 top ].
	y := 20.
	(owner isKindOf: ScrollFrameMorph2)
		ifTrue: [ owner hScrollPixels: 0.
			owner vScrollPixels: 0 ].
	sortedBlocks
		do: [ :s | 
			s position: self position + (20 @ y).
			y := y + s fullBounds height + 15 ].
	self layoutChanged
]

{ #category : #'event handling' }
ScratchScriptsMorph >> click: evt [
	self showMenu: evt
]

{ #category : #drawing }
ScratchScriptsMorph >> drawOn: aCanvas [
	"Fill with my texture patch. Fill with a solid color if there is no texture in the current skin dictionary."

	| patchF clipC y x |
	self isScreenshooting
		ifTrue: [ aCanvas fillRectangle: self bounds color: Color transparent.
			^ self ].
	patchF := ScratchTheme formAt: #scriptsPaneTexture.
	clipC := aCanvas copyClipRect: self bounds.
	y := self top.
	[ y <= self bottom ]
		whileTrue: [ x := self left.
			[ x <= self right ]
				whileTrue: [ clipC paintImage: patchF at: x @ y.
					x := x + patchF width ].
			y := y + patchF height ]
]

{ #category : #'object i/o' }
ScratchScriptsMorph >> fieldsVersion [
	^ 1
]

{ #category : #'event handling' }
ScratchScriptsMorph >> handlesMouseDown: evt [
	
	^ true
]

{ #category : #initialization }
ScratchScriptsMorph >> initialize [

	super initialize.
	color := Color white.
	borderWidth := 0.
	self enableDragNDrop: true.

]

{ #category : #screenshot }
ScratchScriptsMorph >> isScreenshooting [

	^ screenshooting ifNil: [screenshooting := false]

]

{ #category : #testing }
ScratchScriptsMorph >> isScriptEditor [
	^ true
]

{ #category : #'event handling' }
ScratchScriptsMorph >> mouseDown: evt [
	evt hand newKeyboardFocus: nil.
	evt hand waitForClicksOrDrag: self event: evt
]

{ #category : #accessing }
ScratchScriptsMorph >> project [
	^ project
]

{ #category : #accessing }
ScratchScriptsMorph >> project: aProject [
	project := aProject
]

{ #category : #screenshot }
ScratchScriptsMorph >> screenshot [
	"answer a Form of myself apt for exporting"

	| saveForm leftX topY rightX bottomY |
	screenshooting := true.
	self changed.
	saveForm := self imageForm.

	"clip"
	submorphs isEmpty
		ifTrue: [ ^ nil ].
	leftX := submorphs anyOne left.
	topY := submorphs anyOne top.
	rightX := submorphs anyOne right.
	bottomY := submorphs anyOne bottom.
	(self allMorphs select: [ :m | m ~= self ])
		do: [ :m | 
			leftX := leftX min: m left.
			topY := topY min: m top.
			rightX := rightX max: m right.
			bottomY := bottomY max: m bottom ].
	saveForm := saveForm
		copy:
			(leftX @ topY - self position
				rectangle: rightX @ bottomY - self position).
	screenshooting := false.
	self changed.
	^ saveForm
]

{ #category : #'event handling' }
ScratchScriptsMorph >> scriptsMenu: anEvent script: aScript [
	"Present a menu of Scratch script operations."

	| app menu |
	app := self project application.
	menu := MenuMorph new.
	menu target: app.
	menu
		add: 'add sub block'
		target: app
		selector: #addSubBlock:script:
		argumentList:
			{anEvent.
			aScript}.
	menu addLine.
	menu add: 'clean up' target: self selector: #cleanUp.
	menu add: 'save picture of scripts' selector: #saveScriptsToImage.
	menu localize.
	menu popUpEvent: anEvent in: self world
]

{ #category : #'event handling' }
ScratchScriptsMorph >> showMenu: anEvent [
	| m |
	(m := self project) ifNil: [ ^ self ].
	m application currentTarget
		ifNotNil: [ :s | self scriptsMenu: anEvent script: s ]
]

{ #category : #stepping }
ScratchScriptsMorph >> step [
	"Give feedback about possible drop targets."

	| feedbackColor h b targetArg targetAssoc targetP targetBlock |
	feedbackMorph
		ifNil: [ feedbackMorph := BorderedMorph new borderWidth: 3 ]
		ifNotNil: [ feedbackMorph delete ].
	feedbackColor := Color white.
	feedbackMorph useSquareCorners.
	h := self activeHand.
	"h toolType = 'CutTool' ifTrue: [^ self showDeleteFeedback]."
	(self bounds containsPoint: h position)
		ifFalse: [ ^ self ].
	h submorphCount = 1
		ifFalse: [ ^ self ].
	b := h firstSubmorph.
	b isBlockMorph
		ifFalse: [ ^ self ].

	b isReporter
		ifTrue: [ "reporter block"
			(targetArg := self topArgMorphAt: b bounds exclude: nil)
				ifNil: [ ^ self ].
			(targetArg acceptsTypeOf: b)
				ifFalse: [ ^ self ].
			feedbackMorph
				bounds: (targetArg bounds expandBy: 5);
				color: (feedbackColor alpha: 0.4);
				borderColor: feedbackColor;
				useRoundedCorners.
			^ self addMorphFront: feedbackMorph ].

	"non-reporter (i.e. command block or hat block)"
	targetAssoc := b closestAttachTargetIn: self.
	targetAssoc
		ifNil: [ b bottomBlock isCBlock
				ifFalse: [ targetAssoc := b bottomBlock closestAttachTargetIn: self.
					targetAssoc
						ifNotNil: [ targetAssoc value owner isBlockMorph
								ifTrue: [ targetAssoc := nil ] ] ] ].
	targetAssoc ifNil: [ ^ self ].
	targetP := targetAssoc key.
	targetBlock := targetAssoc value.
	feedbackMorph
		borderColor: feedbackColor;
		color: feedbackColor.

	"subtract the attachment point x from the width so that the feedback in CBlock won't stick out"
	feedbackMorph extent: (targetBlock right - targetP x) @ 5.
	self addMorphFront: (feedbackMorph position: targetP)
]

{ #category : #stepping }
ScratchScriptsMorph >> stepTime [

	^ 50

]

{ #category : #stepping }
ScratchScriptsMorph >> topArgMorphAt: aRectangle exclude: aMorph [
	"Give feedback about possible drop targets."

	| stack argM |
	"find the top block or stack under the given point, excluding the given morph"
	stack := submorphs
		detect: [ :m | 
			m ~~ aMorph
				and:
					[ m isBlockMorph and: [ m fullBounds intersects: aRectangle ] ] ]
		ifNone: [ ^ nil ].
	stack
		allMorphsDo: [ :b | 
			(b isCommandBlock and: [ b isHatBlock not ])
				ifTrue: [ 1 to: b argumentCount do: [ :i | 
						argM := b argumentAt: i.
						((argM bounds intersects: aRectangle)
							and: [ argM acceptsDroppedReporters ])
							ifTrue: [ ^ argM ] ] ] ].
	^ nil
]

{ #category : #'dropping/grabbing' }
ScratchScriptsMorph >> wantsDroppedMorph: aMorph event: evt [
	^ aMorph isBlockMorph
]

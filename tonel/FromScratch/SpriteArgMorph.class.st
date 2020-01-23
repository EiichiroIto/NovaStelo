"
I represent a scriptable scratch morph argument for a command block.  Clicking on me and then another point on the screen allows the user to set my value to the scriptable scratch morph that has been clicked on.
"
Class {
	#name : #SpriteArgMorph,
	#superclass : #ArgMorph,
	#instVars : [
		'menuIconMorph',
		'morph'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #other }
SpriteArgMorph >> acceptsDroppedReporters [

	^ true

]

{ #category : #other }
SpriteArgMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the given type."

	aBlockMorph isReporter ifFalse: [^ false].
	^ aBlockMorph isBooleanReporter not

]

{ #category : #'code generation' }
SpriteArgMorph >> argString: aGenerator [
	^ aGenerator spriteArgString: self.
]

{ #category : #other }
SpriteArgMorph >> checkForDeletedMorph [
	"If I refer to a Sprite that has been deleted, nil out my morph field. Do nothing if my morph is a SteloStageMorph"

	(morph isKindOf: Morph) ifFalse: [^ self].
	morph owner ifNotNil: [^ self].

	(morph isStageMorph) ifTrue: [^ self].

	morph := nil.  "nil out reference to deleted sprite"


]

{ #category : #other }
SpriteArgMorph >> clearMorphReference [
	"Clear my morph reference."

	(morph isKindOf: Morph) ifFalse: [^ self].
	morph := nil.
	self updateLabel.

]

{ #category : #other }
SpriteArgMorph >> defaultValue: anObject [
	morph := anObject
]

{ #category : #other }
SpriteArgMorph >> evaluate [
	"Answer either nil, the symbol #mouse, or a Scratch sprite object."

	self checkForDeletedMorph.
	morph isString
		ifTrue: [ morph := owner script project findObjName: morph ].
	^ morph
]

{ #category : #'object i/o' }
SpriteArgMorph >> fieldsVersion [

	^ 1

]

{ #category : #other }
SpriteArgMorph >> fixArgLayout [
	"Set my color to my owner's color."

	self color: (owner color mixed: 0.7 with: (Color gray: 0.3)).

]

{ #category : #'event handling' }
SpriteArgMorph >> handlesMouseDown: evt [

	^ "evt hand toolType isNil and:
		["
		(self topRight - (14@0) corner: self bottomRight) containsPoint: evt cursorPoint
		"]"

]

{ #category : #'object i/o' }
SpriteArgMorph >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		morph
	) from: anObjStream.

]

{ #category : #initialize }
SpriteArgMorph >> initialize [

	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color white.

	labelMorph := StringMorph new
		font: (ScratchTheme argFont);
		color: Color white.
	self addMorph: labelMorph.
	((labelMorph extent y) > 15)
		ifTrue: [ self extent: 20@((labelMorph extent y) + 3) ]
		ifFalse: [ self extent: 20@15 ].
	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.

	morph := nil.
	self updateLabel.

]

{ #category : #'event handling' }
SpriteArgMorph >> mouseDown: evt [

	self presentMenu.

]

{ #category : #'event handling' }
SpriteArgMorph >> presentMenu [
	"Let the user select a Scratch object or the special value #mouse."

	| project objList menu choice |
	(project := self project) ifNil: [^ self].

	"(owner isKindOf: CommandBlockMorph) ifTrue: [sel := owner selector]."

	objList := project scriptsForMenu.
	objList sort: [:obj1 :obj2 | obj1 objName asLowercase < obj2 objName asLowercase].

	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	"sel = #getAttribute:of:
		ifTrue: [
			menu add: ('Stage' localized) selector: #value: argument: frame workPane]
		ifFalse: [
			menu add: 'mouse-pointer' localized selector: #value: argument: #mouse.
			sel = #touching: ifTrue: [menu add: 'edge' localized selector: #value: argument: #edge].
			objList := objList copyWithout: owner receiver]."

	objList size > 0 ifTrue: [menu addLine].
	objList do: [:obj | menu add: obj objName selector: #value: argument: obj].

	menu invokeAt: ActiveHand position in: self world.
	choice ifNil: [^ self].
	morph := choice.
	"self fixGetAttribueBlock."
	self updateLabel.

]

{ #category : #other }
SpriteArgMorph >> printArgOn: aStream [
	"Print this argument morph on the given stream."

	aStream nextPutAll: 's['.
	aStream nextPutAll: self labelMorph contents.
	aStream nextPut: $].

]

{ #category : #stepping }
SpriteArgMorph >> step [

	self updateLabel.

]

{ #category : #stepping }
SpriteArgMorph >> stepTime [

	^ 500

]

{ #category : #'object i/o' }
SpriteArgMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		morph
	) on: anObjStream.

]

{ #category : #stepping }
SpriteArgMorph >> updateLabel [
	"Update my label string."

	| s |
	self checkForDeletedMorph.
	s := ' '.
	morph
		ifNotNil: [ morph isScriptable
				ifTrue: [ s := morph objName ].
			morph isString
				ifTrue: [ s := morph localized.
					morph = #mouse
						ifTrue: [ s := 'mouse-pointer' localized ] ] ].
	labelMorph contents = s
		ifFalse: [ labelMorph contents: ''.
			labelMorph contents: s.
			labelMorph position: self position + borderWidth + (3 @ -1).
			self extent: labelMorph extent + (16 @ 2) + borderWidth.
			menuIconMorph
				position: (self right - borderWidth - 10) @ (self top + borderWidth + 4).
			(self meOrOwnerThatIsA: ScratchBlockPaletteMorph)
				ifNotNil: [ (self meOrOwnerThatIsA: ScratchBlockPaletteMorph) fixLayout ] ]
]

{ #category : #'event handling' }
SpriteArgMorph >> wantsKeyboardFocusFor: aSubmorph [
	"Don't allow shift-click editing of block labels."

	^ false

]

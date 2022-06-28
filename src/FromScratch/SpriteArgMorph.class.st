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
SpriteArgMorph >> argOf: aParser [
	^ aParser spriteArgString: self
]

{ #category : #'code generation' }
SpriteArgMorph >> argString: aGenerator [
	^ aGenerator spriteArgString: self.
]

{ #category : #other }
SpriteArgMorph >> checkForDeletedMorph [
	"If I refer to a Sprite that has been deleted, nil out my morph field. Do nothing if my morph is a SteloStageMorph"

	morph isMorph
		ifFalse: [ ^ self ].
	morph owner ifNotNil: [ ^ self ].
	morph isStageMorph
		ifTrue: [ ^ self ].
	morph := nil	"nil out reference to deleted sprite"
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

{ #category : #other }
SpriteArgMorph >> fixArgLayout [
	"Set my color to my owner's color."

	self color: (owner color mixed: 0.7 with: (Color gray: 0.3)).

]

{ #category : #'event handling' }
SpriteArgMorph >> handlesMouseDown: evt [
	^ (self topRight - (14 @ 0) corner: self bottomRight)
		containsPoint: evt cursorPoint
]

{ #category : #initialize }
SpriteArgMorph >> initialize [
	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color white.
	labelMorph := StringMorph new
		font: ScratchTranslator argFont;
		color: Color white.
	self addMorph: labelMorph.
	self
		extent:
			(labelMorph extent y > 15
				ifTrue: [ 20 @ (labelMorph extent y + 3) ]
				ifFalse: [ 20 @ 15 ]).
	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.
	morph := nil.
	self updateLabel
]

{ #category : #'event handling' }
SpriteArgMorph >> mouseDown: evt [

	self presentMenu.

]

{ #category : #'event handling' }
SpriteArgMorph >> presentMenu [

	"Let the user select a Scratch object or the special value #mouse."

	| project objList ret |
	project := self project.
	project ifNil: [ ^ self ].
	objList := project scriptsForMenu.
	objList sort: [ :obj1 :obj2 | 
		obj1 objName asLowercase < obj2 objName asLowercase ].
	morph := SpSelectDialog new
		         label: 'Select one' localized;
		         items: objList;
		         display: [ :each | each objName ];
		         openModal.
	morph ifNil: [ ^ self ].
	self updateLabel
]

{ #category : #stepping }
SpriteArgMorph >> step [

	self updateLabel.

]

{ #category : #stepping }
SpriteArgMorph >> stepTime [

	^ 500

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
		ifTrue: [ ^ self ].
	labelMorph contents: ''.
	labelMorph contents: s.
	labelMorph position: self position + borderWidth + (3 @ -1).
	self extent: labelMorph extent + (16 @ 2) + borderWidth.
	menuIconMorph
		position: (self right - borderWidth - 10) @ (self top + borderWidth + 4).
	self blockPalette ifNotNil: [ :m | m fixLayout ]
]

{ #category : #'event handling' }
SpriteArgMorph >> wantsKeyboardFocusFor: aSubmorph [
	"Don't allow shift-click editing of block labels."

	^ false

]

"
I represent a scriptable scratch morph argument for a command block.  Clicking on me and then another point on the screen allows the user to set my value to the scriptable scratch morph that has been clicked on.
"
Class {
	#name : #ScriptArgMorph,
	#superclass : #ArgMorph,
	#instVars : [
		'menuIconMorph',
		'selectedScript'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #other }
ScriptArgMorph >> acceptsDroppedReporters [

	^ true

]

{ #category : #other }
ScriptArgMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the given type."

	aBlockMorph isReporter ifFalse: [^ false].
	^ aBlockMorph isBooleanReporter not

]

{ #category : #'code generation' }
ScriptArgMorph >> argOf: aParser [
	^ aParser spriteArgString: self
]

{ #category : #'code generation' }
ScriptArgMorph >> argString: aGenerator [
	^ aGenerator spriteArgString: self.
]

{ #category : #private }
ScriptArgMorph >> checkForDeletedScript [

	selectedScript ifNil: [ ^ self ].
	self project ifNotNil: [ :project |
		selectedScript isString
			ifTrue: [ selectedScript := project scriptNamed: selectedScript ]
			ifFalse: [
				(project scripts includes: selectedScript) ifTrue: [ ^ self ].
				selectedScript := nil ] ]
]

{ #category : #other }
ScriptArgMorph >> defaultValue: anObject [

	selectedScript := anObject
]

{ #category : #other }
ScriptArgMorph >> evaluate [

	"Answer either nil, the symbol #mouse, or a Scratch sprite object."

	self checkForDeletedScript.
	^ selectedScript
]

{ #category : #other }
ScriptArgMorph >> fixArgLayout [
	"Set my color to my owner's color."

	self color: (owner color mixed: 0.7 with: (Color gray: 0.3)).

]

{ #category : #'event handling' }
ScriptArgMorph >> handlesMouseDown: evt [
	^ (self topRight - (14 @ 0) corner: self bottomRight)
		containsPoint: evt cursorPoint
]

{ #category : #initialize }
ScriptArgMorph >> initialize [

	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color white.
	labelMorph := StringMorph new
		              font: ScratchTranslator argFont;
		              color: Color white.
	self addMorph: labelMorph.
	self extent: (labelMorph extent y > 15
			 ifTrue: [ 20 @ (labelMorph extent y + 3) ]
			 ifFalse: [ 20 @ 15 ]).
	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.
	self updateLabel
]

{ #category : #testing }
ScriptArgMorph >> isChoiceArg [

	^ true
]

{ #category : #'event handling' }
ScriptArgMorph >> mouseDown: evt [

	self presentMenu.

]

{ #category : #private }
ScriptArgMorph >> presentMenu [

	"Let the user select a Scratch object or the special value #mouse."

	| project objList tmp |
	project := self project.
	project ifNil: [ ^ self ].
	objList := project scriptsForMenu.
	objList sort: [ :obj1 :obj2 | 
		obj1 objName asLowercase < obj2 objName asLowercase ].
	tmp := SpSelectDialog new
		       label: 'Select one' localized;
		       items: objList;
		       display: [ :each | each objName ];
		       openModal.
	tmp ifNil: [ ^ self ].
	selectedScript := tmp.
	self updateLabel
]

{ #category : #accessing }
ScriptArgMorph >> selectedScript [

	^ selectedScript
]

{ #category : #stepping }
ScriptArgMorph >> step [

	self updateLabel.

]

{ #category : #stepping }
ScriptArgMorph >> stepTime [

	^ 500

]

{ #category : #stepping }
ScriptArgMorph >> updateLabel [

	"Update my label string."

	| s |
	self checkForDeletedScript.
	s := selectedScript ifNil: [ ' ' ] ifNotNil: [ selectedScript objName ].
	labelMorph contents = s ifTrue: [ ^ self ].
	labelMorph contents: ''.
	labelMorph contents: s.
	labelMorph position: self position + borderWidth + (3 @ -1).
	self extent: labelMorph extent + (16 @ 2) + borderWidth.
	menuIconMorph position:
		self right - borderWidth - 10 @ (self top + borderWidth + 4).
	self blockPalette ifNotNil: [ :m | m fixLayout ]
]

{ #category : #'event handling' }
ScriptArgMorph >> wantsKeyboardFocusFor: aSubmorph [
	"Don't allow shift-click editing of block labels."

	^ false

]

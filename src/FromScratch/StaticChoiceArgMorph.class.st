Class {
	#name : #StaticChoiceArgMorph,
	#superclass : #ArgMorph,
	#instVars : [
		'menuIconMorph',
		'choice',
		'options'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #private }
StaticChoiceArgMorph >> argList [

	| list |
	list := self options.
	list isEmpty ifTrue: [ ^ list ].
	^ list collect: #localized
]

{ #category : #'code generation' }
StaticChoiceArgMorph >> argOf: aParser [

	^ aParser choiceArgString: self
]

{ #category : #accessing }
StaticChoiceArgMorph >> choice [

	^ choice

]

{ #category : #accessing }
StaticChoiceArgMorph >> choice: aSymbol [

	"Update the toggle button when an argument is changed within a block."

	| block |
	choice := aSymbol.
	self labelMorphContents: aSymbol asString.
	labelMorph
		position: self position + borderWidth + (3 @ -1);
		layoutChanged;
		changed.
	self extent: labelMorph extent + (16 @ 2) + borderWidth.
	menuIconMorph position:
		self right - borderWidth - 10 @ (self top + borderWidth + 4).
	(block := self meOrOwnerThatIsA: HatBlockMorph) ifNotNil: [ 
		block fixBlockLayout ]
]

{ #category : #accessing }
StaticChoiceArgMorph >> defaultValue: aString [

	"Set my default value."

	self choice: aString
]

{ #category : #evaluation }
StaticChoiceArgMorph >> evaluate [

	"Answer my value."

	^ choice
]

{ #category : #private }
StaticChoiceArgMorph >> fixArgLayout [

	"Set my color to my owner's color."

	self color: (owner color mixed: 0.75 with: (Color gray: 0.45))
]

{ #category : #'event handling' }
StaticChoiceArgMorph >> handlesMouseDown: evt [

	^ (self topRight - (14 @ 0) corner: self bottomRight) containsPoint:
		  evt cursorPoint
]

{ #category : #initialization }
StaticChoiceArgMorph >> initialize [

	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color brown.
	labelMorph := StringMorph new
		              font: ScratchTranslator argFont;
		              color: Color white.
	self addMorph: labelMorph.
	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.
	self choice: #a.
	options := #()
]

{ #category : #testing }
StaticChoiceArgMorph >> isChoiceArg [

	^ true
]

{ #category : #testing }
StaticChoiceArgMorph >> isSquareArg [

	^ true
]

{ #category : #accessing }
StaticChoiceArgMorph >> labelMorphContents: aString [

	labelMorph contents: aString localized
]

{ #category : #'event handling' }
StaticChoiceArgMorph >> mouseDown: evt [

	self presentMenu.

]

{ #category : #accessing }
StaticChoiceArgMorph >> options [

	^ options
]

{ #category : #accessing }
StaticChoiceArgMorph >> options: aCollection [

	options := aCollection
]

{ #category : #private }
StaticChoiceArgMorph >> presentMenu [

	"Pop up a menu of choices."

	| list ret |
	list := self argList.
	list isEmpty ifTrue: [ ^ self ].
	ret := SpScratchPresenter select: 'Select one' localized chooseFrom: list.
	ret ifNil: [ ^ self ].
	self choice: ret
]

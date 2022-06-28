"
I am used to represent an ArgMorph that allows the user to choose from a popup menu of choices. For example, I might allow selection of a sensor port from the list ('a', 'b', 'c', 'd').

In an earlier version of Scratch, I was used to represent boolean values. That usage has been replaced with BooleanArgMorph.

"
Class {
	#name : #ChoiceArgMorph,
	#superclass : #ArgMorph,
	#instVars : [
		'menuIconMorph',
		'choice',
		'getOptionsSelector',
		'getOptionsTarget'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #'code generation' }
ChoiceArgMorph >> argOf: aParser [
	^ aParser choiceArgString: self
]

{ #category : #accessing }
ChoiceArgMorph >> choice [

	^ choice

]

{ #category : #accessing }
ChoiceArgMorph >> choice: aSymbol [
	"Update the toggle button when an argument is changed within a block."

	| block label |
	choice := aSymbol.
	label := aSymbol asString.
	labelMorph
		contents:
			((#(varNames) includes: getOptionsSelector)
				ifTrue: [ label ]
				ifFalse: [ label localized ]).
	labelMorph
		position: self position + borderWidth + (3 @ -1);
		layoutChanged;
		changed.
	self extent: labelMorph extent + (16 @ 2) + borderWidth.
	menuIconMorph
		position: (self right - borderWidth - 10) @ (self top + borderWidth + 4).
	(block := self meOrOwnerThatIsA: HatBlockMorph)
		ifNotNil: [ block fixBlockLayout ]
]

{ #category : #accessing }
ChoiceArgMorph >> defaultValue: aString [
	"Set my default value."

	self choice: aString.

]

{ #category : #evaluation }
ChoiceArgMorph >> evaluate [
	"Answer my value."

	^ choice
]

{ #category : #private }
ChoiceArgMorph >> fixArgLayout [
	"Set my color to my owner's color."

	self color: (owner color mixed: 0.75 with: (Color gray: 0.45)).

]

{ #category : #accessing }
ChoiceArgMorph >> getOptionsSelector [

	^ getOptionsSelector

]

{ #category : #accessing }
ChoiceArgMorph >> getOptionsSelector: aSymbolOrString [
	"Set a selector that is used to get a set of options from my command block's receiver. This is used when the options can change over time, such as selecting from a list of available sounds or costumes in the objects media library."

	getOptionsSelector := aSymbolOrString asSymbol.

]

{ #category : #accessing }
ChoiceArgMorph >> getOptionsTarget [
	^ getOptionsTarget
]

{ #category : #accessing }
ChoiceArgMorph >> getOptionsTarget: anObject [
	getOptionsTarget := anObject
]

{ #category : #'event handling' }
ChoiceArgMorph >> handlesMouseDown: evt [

	^ "evt hand toolType isNil and:
		["
		(self topRight - (14@0) corner: self bottomRight) containsPoint: evt cursorPoint
		"]"

]

{ #category : #initialization }
ChoiceArgMorph >> initialize [
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
	self choice: #a
]

{ #category : #'event handling' }
ChoiceArgMorph >> mouseDown: evt [

	self presentMenu.

]

{ #category : #private }
ChoiceArgMorph >> options [
	"Answer my set of options. If getOptionsSelector is not nil and I'm in a CommandBlock with a non-nil receiver, fetch my set of options by sending getOptionsSelector to that receiver."

	^ self getOptionsSelector
		ifNil: [ #() ]
		ifNotNil:
			[ :selector | (self getOptionsTarget ifNil: [ owner receiver ]) perform: selector ]
]

{ #category : #private }
ChoiceArgMorph >> presentMenu [

	"Pop up a menu of choices."

	| list ret |
	list := self options reject: [ :each | each = '-' ].
	list isEmpty ifTrue: [ ^ self ].
	ret := SpScratchApp
		       select: 'Select one' localized
		       chooseFrom: ((#( varNames ) includes: getOptionsSelector)
				        ifTrue: [ list ]
				        ifFalse: [ list collect: #localized ]).
	ret ifNil: [ ^ self ].
	self choice: ret
]

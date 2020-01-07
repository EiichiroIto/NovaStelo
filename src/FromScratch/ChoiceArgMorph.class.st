"
I am used to represent an ArgMorph that allows the user to choose from a popup menu of choices. For example, I might allow selection of a sensor port from the list ('a', 'b', 'c', 'd').

In an earlier version of Scratch, I was used to represent boolean values. That usage has been replaced with BooleanArgMorph.

"
Class {
	#name : #ChoiceArgMorph,
	#superclass : #ArgMorph,
	#instVars : [
		'menuIconMorph',
		'isBoolean',
		'options',
		'choice',
		'getOptionsSelector'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #accessing }
ChoiceArgMorph >> choice [

	^ choice

]

{ #category : #accessing }
ChoiceArgMorph >> choice: aSymbol [
	"Update the toggle button when an argument is changed within a block."

	| block doLocalization label |
	"frame := self meOrOwnerThatIsA: ScratchFrameMorph."
	"((#soundNames = getOptionsSelector) and:
	 [aSymbol = ('record' localized, ScratchTranslator ellipsesSuffix)]) ifTrue: [
		frame ifNotNil: [^ frame newSound]]."

	"((#sceneNames = getOptionsSelector) and:
	 [aSymbol = ('record' localized, ScratchTranslator ellipsesSuffix)]) ifTrue: [
		frame ifNotNil: [^ frame workPane newScene]]."

	"((#sceneNames = getOptionsSelector) and:
	 [aSymbol = ('re-record' localized, ScratchTranslator ellipsesSuffix)]) ifTrue: [
		frame ifNotNil: [^ frame workPane rerecordScene]]."

	choice := label := aSymbol.
	(label isKindOf: String) ifFalse: [label := label asString].
	doLocalization := (#( varNames ) includes: getOptionsSelector) not.
	doLocalization
		ifTrue:[labelMorph contents: label localized]
		ifFalse:[labelMorph contents: label].
	labelMorph position: self position + borderWidth + (3 @ -1).
	labelMorph layoutChanged; changed.
	self extent: (labelMorph extent + (16@2) + borderWidth).

	menuIconMorph position: (self right - borderWidth - 10)@(self top + borderWidth + 4).

	(block := self meOrOwnerThatIsA: HatBlockMorph) ifNotNil: [
		block fixBlockLayout].

	"(palette := self meOrOwnerThatIsA: ScratchBlockPaletteMorph) ifNil: [^ self].
	(block := self meOrOwnerThatIsA: BlockMorph) ifNil: [^ self]."

	"block isReporter ifTrue: [palette updateWatcherButtonsForFrame: frame].
"
]

{ #category : #accessing }
ChoiceArgMorph >> defaultValue: aString [
	"Set my default value."

	self choice: aString.

]

{ #category : #other }
ChoiceArgMorph >> evaluate [
	"Answer my value."

	isBoolean ifTrue: [^ 'true' = choice].
	^ choice

]

{ #category : #'object i/o' }
ChoiceArgMorph >> fieldsVersion [

	^ 2

]

{ #category : #other }
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

{ #category : #'event handling' }
ChoiceArgMorph >> handlesMouseDown: evt [

	^ "evt hand toolType isNil and:
		["
		(self topRight - (14@0) corner: self bottomRight) containsPoint: evt cursorPoint
		"]"

]

{ #category : #'object i/o' }
ChoiceArgMorph >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		isBoolean
		options
		choice
	) from: anObjStream.
	classVersion = 1 ifTrue: [^ self].

	"fields added in version 2"
	self initFieldsNamed: #(
		getOptionsSelector
	) from: anObjStream.

]

{ #category : #initialization }
ChoiceArgMorph >> initialize [

	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color brown.
	labelMorph := StringMorph new
		font: (ScratchTheme argFont);
		color: Color white.
	self addMorph: labelMorph.
	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.
	isBoolean := false.
	options := #(a b c d).
	self choice: #a.

]

{ #category : #'event handling' }
ChoiceArgMorph >> mouseDown: evt [

	self presentMenu.

]

{ #category : #accessing }
ChoiceArgMorph >> options [
	"Answer my set of options. If getOptionsSelector is not nil and I'm in a CommandBlock with a non-nil receiver, fetch my set of options by sending getOptionsSelector to that receiver."

	(getOptionsSelector notNil and:
	 [(owner respondsTo: #receiver) and:
	 [owner receiver notNil]]) ifTrue: [
		^ owner receiver perform: getOptionsSelector].

	^ options

]

{ #category : #accessing }
ChoiceArgMorph >> options: stringList [

	options := stringList asArray.
	(options includes: choice) ifFalse: [self choice: options first].

]

{ #category : #accessing }
ChoiceArgMorph >> presentMenu [
	"Pop up a menu of choices."

	| optionList doLocalization menu selection option |
	optionList := self options.
	optionList size = 0
		ifTrue: [ ^ self ].
	doLocalization := (#(varNames ) includes: getOptionsSelector) not.
	menu := MenuMorph new.
	menu target: [ :v | selection := v ].
	optionList
		do: [ :sym | 
			'-' = sym
				ifTrue: [ menu addLine ]
				ifFalse: [ doLocalization
						ifTrue: [ option := sym localized ]
						ifFalse: [ option := sym ].
					menu add: option selector: #value: argument: sym ] ].
	menu invokeAt: ActiveHand position in: self world.
	selection ifNotNil: [ self choice: selection ].
]

{ #category : #other }
ChoiceArgMorph >> printArgOn: aStream [
	"Print this argument morph on the given stream."

	aStream nextPutAll: '"', self labelMorph contents, '"'.

]

{ #category : #'object i/o' }
ChoiceArgMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		isBoolean
		options
		choice
		getOptionsSelector
	) on: anObjStream.

]

{ #category : #'event handling' }
ChoiceArgMorph >> wantsKeyboardFocusFor: aSubmorph [
	"Don't allow shift-click editing of block labels."

	^ false

]

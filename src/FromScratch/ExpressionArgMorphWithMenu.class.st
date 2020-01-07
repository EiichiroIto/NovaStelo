"
I represent a literal value such as a number or string. I can be edited by typing or a value can be chosen from a pull-down menu.

"
Class {
	#name : #ExpressionArgMorphWithMenu,
	#superclass : #ExpressionArgMorph,
	#instVars : [
		'menuMorph',
		'getMenuSelector',
		'specialValue'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #'class initialization' }
ExpressionArgMorphWithMenu class >> initialize [
	"self initialize"

	DropDownMenuForm := Form
		extent: 7@4
		depth: 1
		fromArray: #(4261412864 2080374784 939524096 268435456)
		offset: 0@0.
	DropDownMenuForm := DropDownMenuForm colorReduced.  "become a ColorForm"
	DropDownMenuForm colors:
		(Array with: Color transparent with: (Color gray: 0.25)).

]

{ #category : #'code generation' }
ExpressionArgMorphWithMenu >> argString: aGenerator [
	^ aGenerator expressionArgWithMenuString: self.
]

{ #category : #accessing }
ExpressionArgMorphWithMenu >> defaultValue: anObject [
	(anObject isKindOf: String)
		ifTrue: [self specialValue: anObject]
		ifFalse: [super defaultValue: anObject].
]

{ #category : #evaluation }
ExpressionArgMorphWithMenu >> evaluate [
	"Answer the result of evaluating my expression in the context of the given ScratchProcess."

	specialValue ifNotNil: [^ specialValue].
	^ super evaluate

]

{ #category : #'object i/o' }
ExpressionArgMorphWithMenu >> fieldsVersion [

	^ 2

]

{ #category : #private }
ExpressionArgMorphWithMenu >> fixArgLayout [

	| dx |
	dx := 9.
	super fixArgLayout.
	menuMorph ifNil: [^ self].
	self width: self width + dx.
	menuMorph position: (self right - dx - 2)@(self top + (self height // 3)).
	(thisContext sender receiver isKindOf: StringFieldMorph) ifTrue: [
		"clear only when user edit my label, but not on other arg layout changes"
		specialValue := nil].

]

{ #category : #'event handling' }
ExpressionArgMorphWithMenu >> handlesMouseDown: evt [

	^ menuMorph notNil

]

{ #category : #'object i/o' }
ExpressionArgMorphWithMenu >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		menuMorph
		getMenuSelector
	) from: anObjStream.

	classVersion = 1 ifTrue: [^ self].

	"field added in version 2"
	self initFieldsNamed: #(
		specialValue
	) from: anObjStream.

]

{ #category : #accessing }
ExpressionArgMorphWithMenu >> menuSelector [

	^ getMenuSelector


]

{ #category : #accessing }
ExpressionArgMorphWithMenu >> menuSelector: menuSelector [
	"Add a drop-down menu button with the given selector. The selector should result in a menu whose action items are values that can be put into this type argument, typically numbers or strings."

	menuMorph := ImageMorph new form: DropDownMenuForm.
	getMenuSelector := menuSelector.
	self addMorphFront: menuMorph.
	self fixArgLayout.

]

{ #category : #'event handling' }
ExpressionArgMorphWithMenu >> mouseDown: evt [
	| rcvr menu choice ret |
	menuMorph ifNil: [ ^ super mouseDown: evt ].
	evt cursorPoint x < (menuMorph left - 1)
		ifTrue: [ ^ super mouseDown: evt ].
	(getMenuSelector notNil
		and: [ (owner isKindOf: BlockMorph) and: [ (rcvr := owner receiver) notNil ] ])
		ifFalse: [ ^ self beep ].
	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	(rcvr perform: getMenuSelector)
		do: [ :each | menu add: each first selector: #value: argument: each second ].
	menu invokeAt: ActiveHand position in: self world.
	choice ifNil: [ ^ self ].
	evt hand newKeyboardFocus: nil.	"close mini-editor, if any"
	"(#(listIndexMenu listIndexForDeleteMenu) includes: getMenuSelector)
		ifTrue: [ ^ self specialValue: choice ]."
	isNumber
		ifTrue: [ self numExpression: choice ]
		ifFalse: [ self stringExpression: choice ].
]

{ #category : #'code generation' }
ExpressionArgMorphWithMenu >> ownerSelector [
	^ owner selector
]

{ #category : #'code generation' }
ExpressionArgMorphWithMenu >> specialValue [
	^ specialValue
]

{ #category : #accessing }
ExpressionArgMorphWithMenu >> specialValue: aString [
	"A special value is a menu selection such as 'last' for a list index that appears as a string in a number if field. If the user edits the field, then it only accepts numeric input. The argumet is retained in the specialValue instance variable."

	isNumber := true.
	labelMorph contents: aString localized.
	labelMorph
		isNumeric: true;
		position: self position + (0@1).
	self fixArgLayout.
	specialValue := aString.

]

{ #category : #'object i/o' }
ExpressionArgMorphWithMenu >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		menuMorph
		getMenuSelector
		specialValue
	) on: anObjStream.

]

"
I represent a literal value such as a number or string. I can be edited by typing or a value can be chosen from a pull-down menu.

"
Class {
	#name : #ExpressionArgMorphWithMenu,
	#superclass : #ExpressionArgMorph,
	#instVars : [
		'menuMorph',
		'specialValue',
		'getOptionsSelector',
		'getOptionsTarget'
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
	anObject isString
		ifTrue: [ self specialValue: anObject ]
		ifFalse: [ super defaultValue: anObject ]
]

{ #category : #evaluation }
ExpressionArgMorphWithMenu >> evaluate [
	"Answer the result of evaluating my expression in the context of the given ScratchProcess."

	specialValue ifNotNil: [^ specialValue].
	^ super evaluate

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

{ #category : #accessing }
ExpressionArgMorphWithMenu >> getOptionsSelector [

	^ getOptionsSelector


]

{ #category : #accessing }
ExpressionArgMorphWithMenu >> getOptionsSelector: menuSelector [
	"Add a drop-down menu button with the given selector. The selector should result in a menu whose action items are values that can be put into this type argument, typically numbers or strings."

	menuMorph := ImageMorph new form: DropDownMenuForm.
	getOptionsSelector := menuSelector.
	self addMorphFront: menuMorph.
	self fixArgLayout.

]

{ #category : #accessing }
ExpressionArgMorphWithMenu >> getOptionsTarget [
	^ getOptionsTarget
]

{ #category : #accessing }
ExpressionArgMorphWithMenu >> getOptionsTarget: anObject [
	getOptionsTarget := anObject
]

{ #category : #'event handling' }
ExpressionArgMorphWithMenu >> handlesMouseDown: evt [

	^ menuMorph notNil

]

{ #category : #'event handling' }
ExpressionArgMorphWithMenu >> mouseDown: evt [
	| rcvr list choice ret |
	menuMorph ifNil: [ ^ super mouseDown: evt ].
	evt cursorPoint x < (menuMorph left - 1)
		ifTrue: [ ^ super mouseDown: evt ].
	rcvr := self getOptionsTarget.
	rcvr ifNil: [ rcvr := owner receiver ].
	(self getOptionsSelector isNil or: [ rcvr isNil ])
		ifTrue: [ ^ self beep ].
	list := rcvr perform: self getOptionsSelector.
	list isEmpty
		ifTrue: [ ^ self ].
	ret := UIManager default chooseFrom: (list collect: #first).
	ret = 0
		ifTrue: [ ^ self ].
	choice := (list at: ret) second.
	evt hand newKeyboardFocus: nil.
	(#(listIndexNames listIndexForDeleteNames) includes: getOptionsSelector)
		ifTrue: [ ^ self specialValue: choice ].
	isNumber
		ifTrue: [ self numExpression: choice ]
		ifFalse: [ self stringExpression: choice ]
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

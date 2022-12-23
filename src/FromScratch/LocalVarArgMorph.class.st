Class {
	#name : #LocalVarArgMorph,
	#superclass : #ArgMorph,
	#instVars : [
		'iconMorph'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #other }
LocalVarArgMorph >> defaultValue: aString [
	self varName: aString
]

{ #category : #accessing }
LocalVarArgMorph >> defaultValueFromSpec: aString [ 
	self varName: aString
]

{ #category : #evaluation }
LocalVarArgMorph >> evaluate [
	^ labelMorph savedContents
]

{ #category : #private }
LocalVarArgMorph >> fixArgLayout [
	| xInset |
	self extent: labelMorph extent + (2 @ 0) + (iconMorph width @ 0).
	xInset := 3.
	labelMorph position: (self left + xInset) @ self top.
	iconMorph position: labelMorph right @ self top
]

{ #category : #'event handling' }
LocalVarArgMorph >> iconMouseDown: anEvent [
	| morph |
	self blockPalette ifNotNil: [ ^ self ].
	morph := self newLocalVarBlockMorph.
	anEvent hand grabMorph: morph.
	morph center: anEvent hand position
]

{ #category : #initialization }
LocalVarArgMorph >> initialize [
	super initialize.
	self borderWidth: 1.
	self borderInset.
	self color: ScratchTheme blockArgColor.
	self extent: 25 @ 12.

	"To allow for editing in place."
	labelMorph := self newLabelMorph.
	self addMorph: labelMorph.
	iconMorph := self newIconMorph.
	self addMorphFront: iconMorph.
	iconMorph on: #mouseDown send: #iconMouseDown: to: self
]

{ #category : #testing }
LocalVarArgMorph >> isExpressionArg [
	^ true
]

{ #category : #private }
LocalVarArgMorph >> newIconMorph [
	^ Morph new
		color: ScratchTheme variableBlockColor;
		extent: 20 @ labelMorph height;
		yourself
]

{ #category : #private }
LocalVarArgMorph >> newLabelMorph [
	^ StringFieldMorph new
		font: ScratchTranslator argFont;
		color: Color transparent;
		isNumeric: false;
		contents: ''
]

{ #category : #private }
LocalVarArgMorph >> newLocalVarBlockMorph [
	^ LocalVarBlockMorph new
		commandSpec: self varName;
		receiver: owner receiver
]

{ #category : #accessing }
LocalVarArgMorph >> varName [
	^ labelMorph contents asString
]

{ #category : #accessing }
LocalVarArgMorph >> varName: aString [
	labelMorph contents: aString.
	self fixArgLayout
]

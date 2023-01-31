"
I am an abstract superclass for all kinds of argument morphs--morphs that are used to hold the argument for various kinds of BlockMorph.

"
Class {
	#name : #ArgMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'labelMorph'
	],
	#classVars : [
		'DropDownMenuForm'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #'class initialization' }
ArgMorph class >> initialize [
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

{ #category : #testing }
ArgMorph >> acceptsDroppedReporters [
	"Answer true if I accept dropped reporter blocks. Answer false by default."

	^ false

]

{ #category : #testing }
ArgMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the given type. Answer false by default."

	^ false

]

{ #category : #'code generation' }
ArgMorph >> argOf: aParser [
	^ [ self argString: aParser ]
]

{ #category : #'code generation' }
ArgMorph >> argString: aGenerator [
	^ aGenerator argString: self.
]

{ #category : #accessing }
ArgMorph >> blockPalette [
	owner ifNil: [ ^ nil ].
	^ owner blockPalette
]

{ #category : #other }
ArgMorph >> defaultValue: anObject [
	"Set my default value. This default implementation does nothing."

]

{ #category : #drawing }
ArgMorph >> drawHLineFrom: startX to: endX y: yOffset color: c on: aCanvas [

	| y |
	y := self top + yOffset.
	aCanvas
		fillRectangle: ((self left + startX)@y corner: (self left + endX)@(y + 1))
		color: c.

]

{ #category : #other }
ArgMorph >> fixArgLayout [
	"Fix my layout. This default implementation does nothing."
]

{ #category : #testing }
ArgMorph >> isArgMorph [
	"True only for ArgMorphs."

	^ true

]

{ #category : #testing }
ArgMorph >> isChoiceArg [

	^ false
]

{ #category : #testing }
ArgMorph >> isExpressionArg [
	^ false
]

{ #category : #testing }
ArgMorph >> isNumberExpression [
	^ false
]

{ #category : #testing }
ArgMorph >> isReporter [
	"Answer true since every ArgMorph reports a value."

	^ true

]

{ #category : #testing }
ArgMorph >> isSquareArg [

	^ false
]

{ #category : #other }
ArgMorph >> labelMorph [

	^ labelMorph

]

{ #category : #printing }
ArgMorph >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: (labelMorph ifNil: [ '' ] ifNotNil: [ labelMorph contents ]);
		nextPut: $)
]

{ #category : #accessing }
ArgMorph >> project [
	^ owner ifNotNil: [ owner project ]
]

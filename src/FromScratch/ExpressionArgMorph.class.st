"
I represent a literal value such as a number or string. I can be edited.

"
Class {
	#name : #ExpressionArgMorph,
	#superclass : #ArgMorph,
	#instVars : [
		'isNumber'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #queries }
ExpressionArgMorph >> acceptsDroppedReporters [

	^ true

]

{ #category : #queries }
ExpressionArgMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the given type."

	aBlockMorph isReporter ifFalse: [^ false].
	^ isNumber not or: [aBlockMorph isBooleanReporter not]

]

{ #category : #accessing }
ExpressionArgMorph >> defaultValue: anObject [
	anObject isNumber
		ifTrue: [ ^ self numExpression: anObject ].
	anObject isString
		ifTrue: [ ^ self stringExpression: anObject ]
]

{ #category : #accessing }
ExpressionArgMorph >> defaultValueFromSpec: anObject [
	"Like defaultValue:, but '-' in a block spec creates an empty number expression."

	self defaultValue: anObject.
	'-' = anObject ifTrue: [self numExpression: ' '].  "empty, evaluates to zero"

]

{ #category : #drawing }
ExpressionArgMorph >> drawOn: aCanvas [ 

	| darkerC right topY bottomY radius xInset c c2 |
	isNumber ifFalse: [^ super drawOn: aCanvas].

	c2 := self color.
	darkerC := c2 darker.
	right := self width.
	topY := bottomY := radius := self height // 2.
	self height even ifTrue: [topY := bottomY - 1].
	[topY >= 0] whileTrue: [
		xInset := radius - (radius squared - (radius - topY - 1) squared) sqrt rounded.

		self drawHLineFrom: xInset to: (xInset + 1) y: topY color: darkerC on: aCanvas.
		c := (topY < 1) ifTrue: [darkerC] ifFalse: [c2].
		self drawHLineFrom: xInset + 1 to: right - (xInset + 1) y: topY color: c on: aCanvas.
		self drawHLineFrom: (right - (xInset + 1)) to: (right - xInset) y: topY color: darkerC on: aCanvas.

		self drawHLineFrom: xInset to: right - xInset y: bottomY color: c2 on: aCanvas.

		xInset = 0 ifTrue: [
			self drawHLineFrom: xInset + 1 to: xInset + 2 y: topY color: c2 on: aCanvas.
			self drawHLineFrom: xInset to: xInset + 1 y: bottomY color: darkerC on: aCanvas.
			self drawHLineFrom: (right - (xInset + 1)) to: (right - xInset) y: bottomY color: darkerC on: aCanvas].

		bottomY := bottomY + 1.
		topY := topY - 1].


]

{ #category : #evaluation }
ExpressionArgMorph >> evaluate [
	"Answer the result of evaluating my expression in the context of the given ScratchProcess."

	| expr |
	expr := labelMorph savedContents.
	isNumber
		ifTrue: [^ expr asNumberNoError]
		ifFalse: [^ expr].  "string"

]

{ #category : #private }
ExpressionArgMorph >> fixArgLayout [
	| top xInset extraW |
	top := self top.
	isNumber
		ifTrue: [ self extent: labelMorph extent + (5 @ 0).
			"tiny vertical adjustment to account for differences in string rendering"
			"Smalltalk isWindows ifFalse: ["
			top := top + 1.	"]"
			"for tall fonts, add extra width"
			extraW := self height - (1.3 * self width) rounded max: 0.
			extraW > 0
				ifTrue: [ self width: self width + extraW ].
			xInset := 4 + (extraW // 2) ]
		ifFalse: [ self extent: labelMorph extent + (2 @ 0).
			xInset := 3 ].
	labelMorph position: (self left + xInset) @ top
]

{ #category : #initialization }
ExpressionArgMorph >> initialize [
	super initialize.
	isNumber := true.
	self borderWidth: 1.
	self borderInset.
	self color: ScratchTheme blockArgColor.
	self extent: 25 @ 12.

	"To allow for editing in place."
	labelMorph := StringFieldMorph new
		font: ScratchTranslator argFont;
		color: Color transparent.
	self addMorph: labelMorph.
	self numExpression: '10'
]

{ #category : #testing }
ExpressionArgMorph >> isExpressionArg [
	^ true
]

{ #category : #drawing }
ExpressionArgMorph >> isNumberExpression [

	^ isNumber

]

{ #category : #accessing }
ExpressionArgMorph >> loseKeyboardFocus [
	labelMorph keyboardFocusChange: false
]

{ #category : #accessing }
ExpressionArgMorph >> numExpression: aNumber [
	isNumber := true.
	labelMorph isNumeric: true.
	labelMorph
		contents:
			(aNumber isFloat
				ifTrue: [ aNumber printString ]
				ifFalse: [ aNumber asString ]).
	self fixArgLayout
]

{ #category : #accessing }
ExpressionArgMorph >> stringExpression: aString [

	isNumber := false.
	labelMorph isNumeric: false.
	labelMorph contents: aString.
	self fixArgLayout.

]

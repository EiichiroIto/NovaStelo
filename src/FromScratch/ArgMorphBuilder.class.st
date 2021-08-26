Class {
	#name : #ArgMorphBuilder,
	#superclass : #Object,
	#instVars : [
		'dict'
	],
	#category : #'FromScratch-Project'
}

{ #category : #private }
ArgMorphBuilder >> add: aCharacter builder: aBlock [
	(dict includesKey: aCharacter)
		ifTrue: [ self error: 'arg character duplicated!' ].
	dict at: aCharacter put: aBlock
]

{ #category : #accessing }
ArgMorphBuilder >> addBooleanArg: aCharacter [
	self add: aCharacter builder: [ BooleanArgMorph new ]
]

{ #category : #accessing }
ArgMorphBuilder >> addChoiceArg: aCharacter selector: aSymbol [
	self
		add: aCharacter
		builder: [ ChoiceArgMorph new
				getOptionsSelector: aSymbol;
				getOptionsTarget: nil;
				choice: '' ]
]

{ #category : #accessing }
ArgMorphBuilder >> addChoiceArg: aCharacter selector: aSymbol initialChoice: aString [
	self
		add: aCharacter
		builder: [ ChoiceArgMorph new
				getOptionsSelector: aSymbol;
				getOptionsTarget: nil;
				choice: aString ]
]

{ #category : #accessing }
ArgMorphBuilder >> addChoiceArg: aCharacter selector: aSymbol target: anObject initialChoice: aString [
	self
		add: aCharacter
		builder: [ ChoiceArgMorph new
				getOptionsSelector: aSymbol;
				getOptionsTarget: anObject;
				choice: aString ]
]

{ #category : #accessing }
ArgMorphBuilder >> addEventTitleArg: aCharacter [
	self add: aCharacter builder: [ EventTitleMorph new ]
]

{ #category : #accessing }
ArgMorphBuilder >> addLocalVarArg: aCharacter [
	self addLocalVarArg: aCharacter initialVarName: 'x'
]

{ #category : #accessing }
ArgMorphBuilder >> addLocalVarArg: aCharacter initialVarName: aString [
	self
		add: aCharacter
		builder: [ LocalVarArgMorph new varName: aString ]
]

{ #category : #accessing }
ArgMorphBuilder >> addNumberExpressArg: aCharacter initialExpression: aString [
	self add: aCharacter builder: [ ExpressionArgMorph new numExpression: aString ]
]

{ #category : #accessing }
ArgMorphBuilder >> addNumberExpressArg: aCharacter selector: aSymbol target: anObject [
	self
		add: aCharacter
		builder: [ ExpressionArgMorphWithMenu new
				numExpression: (anObject perform: aSymbol) first second asString;
				getOptionsSelector: aSymbol;
				getOptionsTarget: anObject ]
]

{ #category : #accessing }
ArgMorphBuilder >> addNumberExpressArg: aCharacter selector: aSymbol target: anObject initialExpression: aString [
	self
		add: aCharacter
		builder: [ ExpressionArgMorphWithMenu new
				numExpression: aString;
				getOptionsSelector: aSymbol;
				getOptionsTarget: anObject ]
]

{ #category : #accessing }
ArgMorphBuilder >> addSpriteArg: aCharacter [
	self add: aCharacter builder: [ SpriteArgMorph new ]
]

{ #category : #accessing }
ArgMorphBuilder >> addStringExpressArg: aCharacter [
	self add: aCharacter builder: [ ExpressionArgMorph new stringExpression: '' ]
]

{ #category : #initialization }
ArgMorphBuilder >> initialize [
	dict := Dictionary new
]

{ #category : #private }
ArgMorphBuilder >> privDict [
	^ dict
]

{ #category : #accessing }
ArgMorphBuilder >> uncoloredArgMorphFor: specString [
	^ (dict at: (specString at: 2)) value
]

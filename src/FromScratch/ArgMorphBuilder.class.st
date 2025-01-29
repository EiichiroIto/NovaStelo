Class {
	#name : 'ArgMorphBuilder',
	#superclass : 'Object',
	#instVars : [
		'dict'
	],
	#category : 'FromScratch-Project',
	#package : 'FromScratch',
	#tag : 'Project'
}

{ #category : 'private' }
ArgMorphBuilder >> add: aCharacter builder: aBlock [
	(dict includesKey: aCharacter)
		ifTrue: [ self error: 'arg character duplicated!' ].
	dict at: aCharacter put: aBlock
]

{ #category : 'api' }
ArgMorphBuilder >> addBlockSpec: aBlockSpec [

	aBlockSpec isBlockSpec ifTrue: [ ^ self ].
	aBlockSpec isCategory ifTrue: [ ^ self ].
	aBlockSpec isSeparator ifTrue: [ ^ self ].
	aBlockSpec isChoiceArg ifTrue: [ 
		^ self
			  addChoiceArg: aBlockSpec arg
			  options: aBlockSpec options
			  initialChoice: '' ].
	self error
]

{ #category : 'api' }
ArgMorphBuilder >> addBooleanArg: aCharacter [
	self add: aCharacter builder: [ BooleanArgMorph new ]
]

{ #category : 'api' }
ArgMorphBuilder >> addChoiceArg: aCharacter options: aCollection initialChoice: aString [

	self add: aCharacter builder: [ 
		StaticChoiceArgMorph new
			options: aCollection;
			choice: aString ]
]

{ #category : 'api' }
ArgMorphBuilder >> addChoiceArg: aCharacter selector: aSymbol [
	self
		add: aCharacter
		builder: [ ChoiceArgMorph new
				getOptionsSelector: aSymbol;
				getOptionsTarget: nil;
				choice: '' ]
]

{ #category : 'api' }
ArgMorphBuilder >> addChoiceArg: aCharacter selector: aSymbol initialChoice: aString [
	self
		add: aCharacter
		builder: [ ChoiceArgMorph new
				getOptionsSelector: aSymbol;
				getOptionsTarget: nil;
				choice: aString ]
]

{ #category : 'api' }
ArgMorphBuilder >> addChoiceArg: aCharacter selector: aSymbol target: anObject initialChoice: aString [
	self
		add: aCharacter
		builder: [ ChoiceArgMorph new
				getOptionsSelector: aSymbol;
				getOptionsTarget: anObject;
				choice: aString ]
]

{ #category : 'api' }
ArgMorphBuilder >> addChoiceArgDef: aChoiceArgDef [

	self addChoiceArg: aChoiceArgDef arg options: aChoiceArgDef options initialChoice: ''
]

{ #category : 'api' }
ArgMorphBuilder >> addEventTitleArg: aCharacter [
	self add: aCharacter builder: [ EventTitleMorph new ]
]

{ #category : 'api' }
ArgMorphBuilder >> addLocalVarArg: aCharacter [
	self addLocalVarArg: aCharacter initialVarName: 'x'
]

{ #category : 'api' }
ArgMorphBuilder >> addLocalVarArg: aCharacter initialVarName: aString [
	self
		add: aCharacter
		builder: [ LocalVarArgMorph new varName: aString ]
]

{ #category : 'api' }
ArgMorphBuilder >> addNumberExpressArg: aCharacter initialExpression: aString [
	self add: aCharacter builder: [ ExpressionArgMorph new numExpression: aString ]
]

{ #category : 'api' }
ArgMorphBuilder >> addNumberExpressArg: aCharacter selector: aSymbol target: anObject [
	self
		add: aCharacter
		builder: [ ExpressionArgMorphWithMenu new
				numExpression: (anObject perform: aSymbol) first second asString;
				getOptionsSelector: aSymbol;
				getOptionsTarget: anObject ]
]

{ #category : 'api' }
ArgMorphBuilder >> addNumberExpressArg: aCharacter selector: aSymbol target: anObject initialExpression: aString [
	self
		add: aCharacter
		builder: [ ExpressionArgMorphWithMenu new
				numExpression: aString;
				getOptionsSelector: aSymbol;
				getOptionsTarget: anObject ]
]

{ #category : 'api' }
ArgMorphBuilder >> addSpriteArg: aCharacter [
	self add: aCharacter builder: [ ScriptArgMorph new ]
]

{ #category : 'api' }
ArgMorphBuilder >> addStringExpressArg: aCharacter [
	self add: aCharacter builder: [ ExpressionArgMorph new stringExpression: '' ]
]

{ #category : 'api' }
ArgMorphBuilder >> argMorphFor: aCharacter [

	^ (dict at: aCharacter) value
]

{ #category : 'accessing' }
ArgMorphBuilder >> dict [
	^ dict
]

{ #category : 'accessing' }
ArgMorphBuilder >> dict: anObject [

	dict := anObject
]

{ #category : 'initialization' }
ArgMorphBuilder >> initialize [
	dict := Dictionary new
]

{ #category : 'api' }
ArgMorphBuilder >> uncoloredArgMorphFor: specString [
	^ (dict at: (specString at: 2)) value
]

Class {
	#name : 'ScTestScript',
	#superclass : 'ScratchScript',
	#instVars : [
		'objName'
	],
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'arithmetic ops' }
ScTestScript >> abs: aNumber [
	^ aNumber abs
]

{ #category : 'argument menus' }
ScTestScript >> addArgBuilder [

	argMorphBuilder
		addStringExpressArg: $s;
		addSpriteArg: $m;
		addNumberExpressArg: $n initialExpression: '10';
		addEventTitleArg: $e;
		addChoiceArg: $v selector: #varNames
]

{ #category : 'adding' }
ScTestScript >> addBlockSpecs [

	blockMorphBuilder
		addCategory: 'test';
		addReporter: 'abs %n' selector: #abs: arguments: #( -123 )
]

{ #category : 'arithmetic ops' }
ScTestScript >> equal: anObject to: anotherObject [

	^ anObject = anotherObject
]

{ #category : 'evaluation' }
ScTestScript >> evaluator [
	^ self
]

{ #category : 'arithmetic ops' }
ScTestScript >> less: anObject than: anotherObject [

	^ anObject < anotherObject
]

{ #category : 'argument menus' }
ScTestScript >> listVarNames [
	^ #(d 'e f')
]

{ #category : 'accessing' }
ScTestScript >> objName [
	^ objName
]

{ #category : 'accessing' }
ScTestScript >> objName: aString [
	objName := aString
]

{ #category : 'arithmetic ops' }
ScTestScript >> plus: a and: b [
	^ a + b
]

{ #category : 'argument menus' }
ScTestScript >> varNames [
	^ #(a 'b c')
]

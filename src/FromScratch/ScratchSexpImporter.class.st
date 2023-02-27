Class {
	#name : #ScratchSexpImporter,
	#superclass : #ScratchImporter,
	#instVars : [
		'appName'
	],
	#category : #'FromScratch-Converter'
}

{ #category : #'instance creation' }
ScratchSexpImporter class >> appName: aString [
	^ self basicNew
		initialize;
		appName: aString;
		yourself
]

{ #category : #'instance creation' }
ScratchSexpImporter class >> new [
	self shouldNotImplement
]

{ #category : #accessing }
ScratchSexpImporter >> appName [
	^ appName
]

{ #category : #accessing }
ScratchSexpImporter >> appName: anObject [
	appName := anObject
]

{ #category : #private }
ScratchSexpImporter >> cBlockTupleFrom: anArray script: aScript [
	| tuple innerBlock |
	tuple := anArray copy.
	tuple at: 1 put: (tuple at: 1) asSymbol.
	2 to: tuple size - 1 do: [ :each | 
		| arg |
		arg := tuple at: each.
		arg isArray
			ifTrue: [ arg := self tupleFrom: arg script: aScript.
				tuple at: each put: arg ] ].
	innerBlock := tuple at: tuple size.
	innerBlock := innerBlock isEmpty
		ifTrue: [ nil ]
		ifFalse: [ innerBlock collect: [ :each | self tupleFrom: each script: aScript ] ].
	tuple at: tuple size put: innerBlock.
	^ tuple
]

{ #category : #private }
ScratchSexpImporter >> evaluateArg: anObject script: aScript [
	anObject isArray
		ifTrue: [ ^ self tupleFrom: anObject script: aScript ]
		ifFalse: [ anObject isString
				ifTrue: [ anObject isNumberString
						ifTrue: [ ^ anObject asNumberNoError ] ] ].
	^ anObject
]

{ #category : #private }
ScratchSexpImporter >> eventBlockTupleFor: aString [

	^ { 
		  #EventHatMorph.
		  aString }
]

{ #category : #private }
ScratchSexpImporter >> getVarTupleFrom: aCollection script: aScript [

	^ { 
		  #readVariable.
		  aCollection second }
]

{ #category : #private }
ScratchSexpImporter >> ifElseTupleFrom: anArray script: aScript [
	| cond trueBlock falseBlock |
	cond := self tupleFrom: anArray second script: aScript.
	trueBlock := anArray third.
	trueBlock := trueBlock isEmpty
		ifTrue: [ nil ]
		ifFalse: [ trueBlock collect: [ :each | self tupleFrom: each script: aScript ] ].
	falseBlock := anArray fourth.
	falseBlock := falseBlock isEmpty
		ifTrue: [ nil ]
		ifFalse: [ falseBlock collect: [ :each | self tupleFrom: each script: aScript ] ].
	^ {anArray first asSymbol.
	cond.
	trueBlock.
	falseBlock}
]

{ #category : #accessing }
ScratchSexpImporter >> import: aString to: anApplication [
	| lex list |
	project := anApplication project.
	lex := SexpLexer new read: aString.
	list := SexpParser new parse: lex.
	self importWorld: list.
]

{ #category : #accessing }
ScratchSexpImporter >> importCode: anArray into: aScript [
	anArray first = 'when'
		ifTrue: [ ^ self
				importEvent: anArray third
				for: aScript
				eventName: anArray second ].
	anArray first = 'sub'
		ifTrue:
			[ ^ self importSub: anArray third for: aScript subName: anArray second ].
	anArray first isArray
		ifTrue:
			[ ^ self importCodes: anArray into: aScript ].
	^ nil
]

{ #category : #private }
ScratchSexpImporter >> importCodes: aCollection into: aScript [
	| block prev tuple top |
	prev := aScript blocksBin.
	top := nil.
	aCollection
		do: [ :each | 
			tuple := self tupleFrom: each script: aScript.
			block := aScript blockFromTuple: tuple.
			top
				ifNil: [ top := block.
					prev addMorph: block ]
				ifNotNil: [ prev nextBlock: block ].
			prev := block ].
	^ top
]

{ #category : #private }
ScratchSexpImporter >> importEvent: aCollection for: aScript eventName: aString [

	| tuple |
	tuple := self eventBlockTupleFor: aString.
	^ self importHat: aCollection for: aScript tuple: tuple
]

{ #category : #private }
ScratchSexpImporter >> importHat: aCollection for: aScript tuple: anArray [

	| block prev tuple top |
	tuple := anArray.
	top := block := aScript blockFromTuple: tuple.
	prev := aScript blocksBin.
	prev addMorph: block.
	prev := block.
	aCollection do: [ :each | 
		tuple := self tupleFrom: each script: aScript.
		block := aScript blockFromTuple: tuple.
		prev nextBlock: block.
		prev := block ].
	^ top
]

{ #category : #private }
ScratchSexpImporter >> importScripts: aCollection [
	| script |
	aCollection
		do: [ :each | 
			each first = 'for'
				ifTrue: [ script := project findObjName: each second.
					each third do: [ :v | self importVarOrList: v to: script ].
					self importScripts: each fourth for: script ] ]
]

{ #category : #private }
ScratchSexpImporter >> importScripts: aCollection for: aScript [
	aCollection
		do: [ :each | 
			each first = 'when'
				ifTrue: [ self importEvent: each third for: aScript eventName: each second ].
			each first = 'sub'
				ifTrue: [ self importSub: each third for: aScript subName: each second ]].
	aScript cleanUp
]

{ #category : #private }
ScratchSexpImporter >> importSub: aCollection for: aScript subName: aString [

	| tuple |
	tuple := self subBlockTupleFor: aString.
	^ self importHat: aCollection for: aScript tuple: tuple
]

{ #category : #private }
ScratchSexpImporter >> importVarOrList: anObject to: aScript [
	anObject isString
		ifTrue: [ ^ aScript addVariable: anObject ].
	self assert: anObject isArray.
	anObject first = 'var'
		ifTrue: [ ^ aScript addVariable: anObject second ].
	anObject first = 'list'
		ifTrue: [ ^ aScript addList: anObject second ]
]

{ #category : #private }
ScratchSexpImporter >> importWorld: aCollection [
	aCollection first = appName
		ifFalse: [ self error ].
	aCollection second do: [ :each | project assureExistsBreed: each ].
	self importScripts: aCollection third
]

{ #category : #private }
ScratchSexpImporter >> operatorTupleFrom: aCollection script: aScript [

	| tuple |
	tuple := aCollection copy.
	self updateArgs: tuple script: aScript.
	^ tuple
]

{ #category : #private }
ScratchSexpImporter >> setVarTupleFrom: aCollection script: aScript [
	| arg |
	arg := aCollection third.
	arg := self evaluateArg: arg script: aScript.
	^ {#changeVariable.
	aCollection second.
	aCollection first asSymbol.
	arg}
]

{ #category : #private }
ScratchSexpImporter >> startBlockTupleFor: aString [

	^ { aString asSymbol }
]

{ #category : #private }
ScratchSexpImporter >> subBlockTupleFor: aString [

	^ { #sub:. aString }
]

{ #category : #private }
ScratchSexpImporter >> tupleFrom: aCollection script: aScript [

	| selector tuple |
	selector := aCollection first asSymbol.
	(aScript getVarSelectors includes: selector) ifTrue: [ 
		^ self getVarTupleFrom: aCollection script: aScript ].
	(aScript setVarSelectors includes: selector) ifTrue: [ 
		^ self setVarTupleFrom: aCollection script: aScript ].
	(aScript ifElseBlockSelectors includes: selector) ifTrue: [ 
		^ self ifElseTupleFrom: aCollection script: aScript ].
	(aScript cBlockSelectors includes: selector) ifTrue: [ 
		^ self cBlockTupleFrom: aCollection script: aScript ].
	tuple := aCollection copy.
	self updateArgs: tuple script: aScript.
	^ tuple
]

{ #category : #private }
ScratchSexpImporter >> updateArgs: anArray script: aScript [
	anArray at: 1 put: (anArray at: 1) asSymbol.
	2 to: anArray size do: [ :each | 
		| arg |
		arg := anArray at: each.
		arg := self evaluateArg: arg script: aScript.
		anArray at: each put: arg ]
]

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
ScratchSexpImporter >> cBlockTupleFrom: anArray [
	| tuple innerBlock |
	tuple := anArray copy.
	tuple at: 1 put: (tuple at: 1) asSymbol.
	2 to: tuple size - 1 do: [ :each | 
		| arg |
		arg := tuple at: each.
		arg isArray
			ifTrue: [ arg := self tupleFrom: arg.
				tuple at: each put: arg ] ].
	innerBlock := tuple at: tuple size.
	innerBlock := innerBlock isEmpty
		ifTrue: [ nil ]
		ifFalse: [ innerBlock collect: [ :each | self tupleFrom: each ] ].
	tuple at: tuple size put: innerBlock.
	^ tuple
]

{ #category : #private }
ScratchSexpImporter >> evaluateArg: anObject [
	anObject isArray
		ifTrue: [ ^ self tupleFrom: anObject ]
		ifFalse: [ anObject isString
				ifTrue: [ anObject isNumberString
						ifTrue: [ ^ anObject asNumberNoError ] ] ].
	^ anObject
]

{ #category : #private }
ScratchSexpImporter >> eventBlockTupleFor: aString [
	^ { #EventHatMorph. aString }
]

{ #category : #private }
ScratchSexpImporter >> getVarTupleFrom: aCollection [
	^ {#readVariable.
	aCollection second}
]

{ #category : #private }
ScratchSexpImporter >> ifElseTupleFrom: anArray [
	| cond trueBlock falseBlock |
	cond := self tupleFrom: anArray second.
	trueBlock := anArray third.
	trueBlock := trueBlock isEmpty
		ifTrue: [ nil ]
		ifFalse: [ trueBlock collect: [ :each | self tupleFrom: each ] ].
	falseBlock := anArray fourth.
	falseBlock := falseBlock isEmpty
		ifTrue: [ nil ]
		ifFalse: [ falseBlock collect: [ :each | self tupleFrom: each ] ].
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
			tuple := self tupleFrom: each.
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
	| block prev tuple top |
	prev := aScript blocksBin.
	tuple := self eventBlockTupleFor: aString.
	top := block := aScript hatBlockFromTuple: tuple.
	prev addMorph: block.
	prev := block.
	aCollection
		do: [ :each | 
			tuple := self tupleFrom: each.
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
	| block prev tuple top |
	prev := aScript blocksBin.
	tuple := self subBlockTupleFor: aString.
	top := block := aScript hatBlockFromTuple: tuple.
	prev addMorph: block.
	prev := block.
	aCollection
		do: [ :each | 
			tuple := self tupleFrom: each.
			block := aScript blockFromTuple: tuple.
			prev nextBlock: block.
			prev := block ].
	^ top
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
ScratchSexpImporter >> operatorTupleFrom: aCollection [

	| tuple |
	tuple := aCollection copy.
	self updateArgs: tuple.
	^ tuple
]

{ #category : #private }
ScratchSexpImporter >> setVarTupleFrom: aCollection [
	| arg |
	arg := aCollection third.
	arg := self evaluateArg: arg.
	^ {#changeVariable.
	aCollection second.
	aCollection first asSymbol.
	arg}
]

{ #category : #private }
ScratchSexpImporter >> subBlockTupleFor: aString [
	^ { #SubHatMorph. aString }
]

{ #category : #private }
ScratchSexpImporter >> tupleFrom: aCollection [
	| selector tuple |
	selector := aCollection first asSymbol.
	"(ScratchBlockParser isInvOperator: selector)
		ifTrue: [ ^ self operatorTupleFrom: aCollection ]."
	selector = #getVar
		ifTrue: [ ^ self getVarTupleFrom: aCollection ].
	(#(setVar:to: changeVar:by:) includes: selector)
		ifTrue: [ ^ self setVarTupleFrom: aCollection ].
	selector = #doIfElse
		ifTrue: [ ^ self ifElseTupleFrom: aCollection ].
	(#(doIf doRepeat doUntil doForever doWhile doIterate) includes: selector)
		ifTrue: [ ^ self cBlockTupleFrom: aCollection ].
	tuple := aCollection copy.
	self updateArgs: tuple.
	^ tuple
]

{ #category : #private }
ScratchSexpImporter >> updateArgs: anArray [
	anArray at: 1 put: (anArray at: 1) asSymbol.
	2 to: anArray size do: [ :each | 
		| arg |
		arg := anArray at: each.
		arg := self evaluateArg: arg.
		anArray at: each put: arg ]
]

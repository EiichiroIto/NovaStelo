Class {
	#name : 'ScratchBytecodeGenerator',
	#superclass : 'ScratchGenerator',
	#instVars : [
		'stream',
		'labelId',
		'address',
		'subTable',
		'script'
	],
	#category : 'Microworld-Bytecode',
	#package : 'Microworld',
	#tag : 'Bytecode'
}

{ #category : 'utilities' }
ScratchBytecodeGenerator class >> unimplementedSelectors [

	"ScratchBytecodeGenerator unimplementedSelectors"

	^ SpScratchApp allBlockSymbols
	  \ (self subclasses first methods collect: #selector)
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> address [
	^ address
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> address: anInteger [
	address := anInteger.
]

{ #category : 'private' }
ScratchBytecodeGenerator >> addressOfSubName: aString [
	subTable ifNil: [ self error ].
	^ subTable at: aString
]

{ #category : 'code injection' }
ScratchBytecodeGenerator >> appendCall: aString [
	stream
		nextPut: (ScratchBytecodeCall subName: aString address: (self addressOfSubName: aString))
]

{ #category : 'code injection' }
ScratchBytecodeGenerator >> appendLabel: anInteger [
	stream nextPut: (ScratchBytecodeLabel id: anInteger).
]

{ #category : 'code injection' }
ScratchBytecodeGenerator >> appendSymbol: aSymbol [
	stream nextPut: (ScratchBytecodeSymbol selector: aSymbol).
]

{ #category : 'code injection' }
ScratchBytecodeGenerator >> appendSymbol: aSymbol withJump: anInteger [
	stream nextPut: (ScratchBytecodeSymbolWithJump selector: aSymbol labelId: anInteger).
]

{ #category : 'code injection' }
ScratchBytecodeGenerator >> appendValue: anObject [
	| v |
	v := anObject isBlock
		ifTrue: [ anObject value ]
		ifFalse: [ anObject ].
	v ifNil: [ ^ self ].
	stream nextPut: (ScratchBytecodeValue data: v).
]

{ #category : 'code injection' }
ScratchBytecodeGenerator >> binaryCommand: aSymbol arg1: anObject1 arg2: anObject2 [
	self appendValue: anObject1.
	self appendValue: anObject2.
	self appendSymbol: aSymbol.
	^ nil
]

{ #category : 'private' }
ScratchBytecodeGenerator >> code [

	| firstPass array out |
	firstPass := stream contents.
	array := self labelsAndJumpsFor: firstPass.
	self resolveJumpAddress: array second using: array first.
	out := WriteStream on: Array new.
	firstPass do: [ :each | each putOn: out ].
	out nextPut: #stop.
	^ out contents
]

{ #category : 'control ops' }
ScratchBytecodeGenerator >> doIfBegin: cond [

	self subclassResponsibility
]

{ #category : 'control ops' }
ScratchBytecodeGenerator >> doIfEnd: anInteger [

	self subclassResponsibility
]

{ #category : 'control ops' }
ScratchBytecodeGenerator >> doUntilBegin [

	self subclassResponsibility
]

{ #category : 'control ops' }
ScratchBytecodeGenerator >> doUntilEnd: cond id: id [

	self subclassResponsibility
]

{ #category : 'arg generator' }
ScratchBytecodeGenerator >> eventTitleString: aString [

	aString isEmpty ifTrue: [ ^ nil ].
	^ script project eventIdFor: aString asSymbol
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateDoIfBegin: aMorph [

	| cond id |
	cond := aMorph blockArgs first argString: parser.
	id := self doIfBegin: cond.
	aMorph labelId: id
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateDoIfEnd: aMorph [

	self doIfEnd: aMorph labelId
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateDoUntilBegin: aMorph [ 

	| id |
	id := self doUntilBegin.
	aMorph labelId: id
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateDoUntilEnd: aMorph [ 

	| cond id |
	cond := aMorph blockArgs first argString: parser.
	id := aMorph labelId.
	self doUntilEnd: cond id: id
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateEmptySubBody [

	"do nothing"
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateEventFooter: aString [ 

	self stopThread
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateEventHeader: aString [

	"do nothing"
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateIndent: anInteger [

	"do nothing"
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generatePass [

	"do nothing"
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateSubHeader: aString [

	"do nothing"
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> generateSubVars: aCollection [

	"do nothing"
]

{ #category : 'initialization' }
ScratchBytecodeGenerator >> initialize [
	super initialize.
	stream := WriteStream on: Array new.
	labelId := BaseId new.
	address := 1.
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> labelId [
	^ labelId
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> labelId: anObject [

	labelId := anObject
]

{ #category : 'private' }
ScratchBytecodeGenerator >> labelsAndJumpsFor: aCollection [
	| labels jumps |
	labels := Array new: labelId size.
	jumps := OrderedCollection new.
	aCollection
		do: [ :each | 
			each isLabel
				ifTrue: [ labels at: each id put: address ].
			each isJump
				ifTrue: [ jumps add: each ].
			address := address + each codeSize ].
	^ Array with: labels with: jumps asArray
]

{ #category : 'private' }
ScratchBytecodeGenerator >> literalStringFrom: anObject [
	anObject isString
		ifTrue: [ ^ anObject asNumberNoError ].
	anObject isNumber
		ifTrue: [ ^ anObject ].
	^ 0
]

{ #category : 'code injection' }
ScratchBytecodeGenerator >> nullaryCommand: aSymbol [
	self appendSymbol: aSymbol.
	^ nil
]

{ #category : 'private' }
ScratchBytecodeGenerator >> resolveJumpAddress: aCollection using: anArray [
	aCollection
		do: [ :each | 
			each isJump
				ifTrue: [ each address: (anArray at: each labelId) ] ].
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> script [

	^ script
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> script: anObject [

	script := anObject
]

{ #category : 'arg generator' }
ScratchBytecodeGenerator >> spriteArgString: aMorph [

	^ aMorph breedNo
]

{ #category : 'control ops' }
ScratchBytecodeGenerator >> stopThread [

	self subclassResponsibility
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> stream [
	^ stream
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> stream: anObject [

	stream := anObject
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> subTable [
	^ subTable
]

{ #category : 'accessing' }
ScratchBytecodeGenerator >> subTable: aDictionary [
	subTable := aDictionary.
]

{ #category : 'code injection' }
ScratchBytecodeGenerator >> ternaryCommand: aSymbol arg1: anObject1 arg2: anObject2 arg3: anObject3 [
	self appendValue: anObject1.
	self appendValue: anObject2.
	self appendValue: anObject3.
	self appendSymbol: aSymbol.
	^ nil
]

{ #category : 'code injection' }
ScratchBytecodeGenerator >> unaryCommand: aSymbol arg: anObject [
	self appendValue: anObject.
	self appendSymbol: aSymbol.
	^ nil
]

{ #category : 'code generator' }
ScratchBytecodeGenerator >> varNamesUsedIn: aMorph [

	^ #(  )
]

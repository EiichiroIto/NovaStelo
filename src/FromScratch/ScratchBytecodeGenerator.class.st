Class {
	#name : #ScratchBytecodeGenerator,
	#superclass : #Object,
	#instVars : [
		'stream',
		'labelId',
		'address',
		'subTable'
	],
	#category : #'FromScratch-Process'
}

{ #category : #accessing }
ScratchBytecodeGenerator >> address [
	^ address
]

{ #category : #accessing }
ScratchBytecodeGenerator >> address: anInteger [
	address := anInteger.
]

{ #category : #private }
ScratchBytecodeGenerator >> addressOfSubName: aString [
	subTable ifNil: [ self error ].
	^ subTable at: aString
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> and: x with: y [
	^ self binaryCommand: #and arg1: x arg2: y
]

{ #category : #private }
ScratchBytecodeGenerator >> appendCall: aString [
	stream
		nextPut: (ScratchBytecodeCall subName: aString address: (self addressOfSubName: aString))
]

{ #category : #private }
ScratchBytecodeGenerator >> appendLabel: anInteger [
	stream nextPut: (ScratchBytecodeLabel id: anInteger).
]

{ #category : #private }
ScratchBytecodeGenerator >> appendSymbol: aSymbol [
	stream nextPut: (ScratchBytecodeSymbol selector: aSymbol).
]

{ #category : #private }
ScratchBytecodeGenerator >> appendSymbol: aSymbol withJump: anInteger [
	stream nextPut: (ScratchBytecodeSymbolWithJump selector: aSymbol labelId: anInteger).
]

{ #category : #private }
ScratchBytecodeGenerator >> appendValue: anObject [
	| v |
	v := anObject isBlock
		ifTrue: [ anObject value ]
		ifFalse: [ anObject ].
	v ifNil: [ ^ self ].
	stream nextPut: (ScratchBytecodeValue data: v).
]

{ #category : #private }
ScratchBytecodeGenerator >> binaryCommand: aSymbol arg1: anObject1 arg2: anObject2 [
	self appendValue: anObject1.
	self appendValue: anObject2.
	self appendSymbol: aSymbol.
	^ nil
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> callSub: aString [
	self appendCall: aString.
]

{ #category : #accessing }
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

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> computeFunction: aSymbol of: x [
	^ self unaryCommand: aSymbol arg: x
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> divide: x by: y [
	^ self binaryCommand: #div arg1: x arg2: y
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> doIfBegin: cond [
	| id |
	id := labelId newNo.
	self appendValue: cond.
	self appendSymbol: #jumpIfFalse withJump: id.
	^ id
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> doIfElse: orgId [
	| newId |
	newId := labelId newNo.
	self appendSymbol: #jump withJump: newId.	
	self appendLabel: orgId.
	^ newId
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> doIfEnd: id [
	self appendLabel: id.
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> doRepeatBegin: num [
	| label1 label2 |
	label1 := labelId newNo.
	label2 := labelId newNo.
	self appendValue: num.
	self appendLabel: label1.
	self appendSymbol: #dup.
	self appendValue: 0.
	self appendSymbol: #equal.
	self appendSymbol: #jumpIfTrue withJump: label2.
	^ 	Array with: label1 with: label2
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> doRepeatEndLabels: aCollection [
	self appendSymbol: #dec.
	self appendSymbol: #jump withJump: aCollection first.
	self appendLabel: aCollection second.
	self appendSymbol: #drop.
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> doUntilBegin [
	| id |
	id := labelId newNo.
	self appendLabel: id.
	^ id
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> doUntilEnd: cond id: id [
	self appendValue: cond.
	self appendSymbol: #jumpIfFalse withJump: id.
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> equal: x to: y [
	^ self binaryCommand: #equal arg1: x arg2: y
]

{ #category : #'sensing ops' }
ScratchBytecodeGenerator >> getId [
	^ self nullaryCommand: #getId
]

{ #category : #initialization }
ScratchBytecodeGenerator >> initialize [
	super initialize.
	stream := WriteStream on: Array new.
	labelId := BaseId new.
	address := 1.
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> is: a between: x and: y [
	self lessEqual: x than: a.
	self lessEqual: a than: y.
	self appendSymbol: #and.
	^ nil
]

{ #category : #private }
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

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> less: x than: y [
	^ self binaryCommand: #less arg1: x arg2: y
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> lessEqual: x than: y [
	^ self binaryCommand: #lessEqual arg1: x arg2: y
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> minus: x with: y [
	^ self binaryCommand: #minus arg1: x arg2: y
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> mod: x by: y [
	^ self binaryCommand: #mod arg1: x arg2: y
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> multiply: x and: y [
	^ self binaryCommand: #mul arg1: x arg2: y
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> not: x [
	^ self unaryCommand: #not arg: x
]

{ #category : #private }
ScratchBytecodeGenerator >> nullaryCommand: aSymbol [
	self appendSymbol: aSymbol.
	^ nil
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> or: x with: y [
	^ self binaryCommand: #or arg1: x arg2: y
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> plus: x and: y [
	^ self binaryCommand: #plus arg1: x arg2: y
]

{ #category : #private }
ScratchBytecodeGenerator >> privLabelId [
	^ labelId
]

{ #category : #private }
ScratchBytecodeGenerator >> privStream [
	^ stream
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> randomFrom: x to: y [
	^ self binaryCommand: #randomFromTo arg1: x arg2: y
]

{ #category : #private }
ScratchBytecodeGenerator >> resolveJumpAddress: aCollection using: anArray [
	aCollection
		do: [ :each | 
			each isJump
				ifTrue: [ each address: (anArray at: each labelId) ] ].
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> return: anInteger [
	self unaryCommand: #return arg: anInteger
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> returnValue [
	^ self nullaryCommand: #returnValue
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> rounded: x [
	^ self unaryCommand: #rounded arg: x
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> stopAll [
	self nullaryCommand: #stopAll.
]

{ #category : #'control ops' }
ScratchBytecodeGenerator >> stopThread [
	self nullaryCommand: #stop.
]

{ #category : #accessing }
ScratchBytecodeGenerator >> subTable [
	^ subTable
]

{ #category : #accessing }
ScratchBytecodeGenerator >> subTable: aDictionary [
	subTable := aDictionary.
]

{ #category : #private }
ScratchBytecodeGenerator >> ternaryCommand: aSymbol arg1: anObject1 arg2: anObject2 arg3: anObject3 [
	self appendValue: anObject1.
	self appendValue: anObject2.
	self appendValue: anObject3.
	self appendSymbol: aSymbol.
	^ nil
]

{ #category : #'arithmetic ops' }
ScratchBytecodeGenerator >> truncated: x [
	^ self unaryCommand: #truncated arg: x
]

{ #category : #private }
ScratchBytecodeGenerator >> unaryCommand: aSymbol arg: anObject [
	self appendValue: anObject.
	self appendSymbol: aSymbol.
	^ nil
]

Class {
	#name : 'ScratchSexpGenerator',
	#superclass : 'Object',
	#instVars : [
		'parser',
		'stream',
		'indents',
		'position',
		'wantsLinefeed',
		'indentLevel'
	],
	#category : 'FromScratch-Converter',
	#package : 'FromScratch',
	#tag : 'Converter'
}

{ #category : 'arg generator' }
ScratchSexpGenerator >> argString: anArgMorph [ 
	| v |
	^ anArgMorph labelMorph
		ifNil: [self error: 'nil arg']
		ifNotNil: 
			[v := anArgMorph evaluate.
			self literalStringFrom: v]
]

{ #category : 'arg generator' }
ScratchSexpGenerator >> eventTitleString: aString [
	^ aString
]

{ #category : 'arg generator' }
ScratchSexpGenerator >> expressionArgWithMenuString: aMorph [
	^ aMorph evaluate
]

{ #category : 'arg generator' }
ScratchSexpGenerator >> falseString [
	^ 0
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateBegin: aSymbol morph: aMorph [
	self
		printOpenParen;
		printString: aSymbol.
	aMorph blockArgs
		do: [ :each | 
			self
				printSpace;
				printString: (each argString: parser) ].
	self generateLineFeed.
	self printOpenParen
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateCenter: aSymbol morph: aMorph [
	self printCloseParen.
	self generateLineFeed.
	self printOpenParen
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateCode: aSymbol morph: aBlockMorph [
	self
		printOpenParen;
		printString: aSymbol.
	aBlockMorph blockArgs
		do: [ :each | 
			self
				printSpace;
				printString: (each argString: parser) ].
	self printCloseParen.
	self generateLineFeed
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateEnd: aSymbol morph: aMorph [
	self
		printCloseParen;
		printCloseParen.
	self generateLineFeed
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateEventFooter: aString [
	self
		printCloseParen;
		printCloseParen
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateEventHeader: aString [
	"self generateLineFeed."
	self
		printOpenParen;
		printString: 'when';
		printSpace;
		printString: aString.
	self generateLineFeed.
	self printOpenParen
]

{ #category : 'private' }
ScratchSexpGenerator >> generateIndent: anInteger [ 
	"do nothing"
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateLineFeed [
	wantsLinefeed := true
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generatePass [
	"do nothing"
]

{ #category : 'arg generator' }
ScratchSexpGenerator >> generateReporter: aSymbol morph: aReporterMorph [
	| out |
	out := WriteStream on: String new.
	out nextPut: $(.
	out nextPutAll: aSymbol.
	aReporterMorph blockArgs
		do: [ :each | 
			out nextPut: Character space.
			out nextPutAll: (each argString: parser) asString ].
	out nextPut: $).
	^ out contents
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateSubFooter: aString [
	self
		printCloseParen;
		printCloseParen
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateSubHeader: aString [
	self generateLineFeed.
	self
		printOpenParen;
		printString: 'sub';
		printSpace;
		printString: aString.
	self generateLineFeed.
	self printOpenParen
]

{ #category : 'code generator' }
ScratchSexpGenerator >> generateSubVars: aCollection [ 
	"do nothing"
]

{ #category : 'accessing' }
ScratchSexpGenerator >> indentLevel [

	^ indentLevel
]

{ #category : 'accessing' }
ScratchSexpGenerator >> indentLevel: anObject [

	indentLevel := anObject
]

{ #category : 'code generator' }
ScratchSexpGenerator >> indentLevelFor: aString [
	^ 2
]

{ #category : 'accessing' }
ScratchSexpGenerator >> indents [

	^ indents
]

{ #category : 'accessing' }
ScratchSexpGenerator >> indents: anObject [

	indents := anObject
]

{ #category : 'initialization' }
ScratchSexpGenerator >> initialize [
	super initialize.
	parser := ScratchBlockParser new generator: self.
	stream := WriteStream on: String new.
	indents := Array with: 0.
	indentLevel := 1.
	position := 0.
	wantsLinefeed := false
]

{ #category : 'arg generator' }
ScratchSexpGenerator >> literalStringFrom: anObject [
	anObject isString
		ifTrue: [ ^ (SexpLexer quotedString: anObject) ].
	anObject isNumber
		ifTrue: [ ^ anObject ].
	self error.
]

{ #category : 'arg generator' }
ScratchSexpGenerator >> localVarArgString: aString [ 
	^ aString
]

{ #category : 'api' }
ScratchSexpGenerator >> parseBlock: aTopBlock initialIndent: anInteger [

	indents at: 1 put: anInteger.
	position := anInteger.
	parser parseBlock: aTopBlock.
	^ stream contents
]

{ #category : 'accessing' }
ScratchSexpGenerator >> parser [

	^ parser
]

{ #category : 'accessing' }
ScratchSexpGenerator >> parser: anObject [

	parser := anObject.
	parser generator: self
]

{ #category : 'accessing' }
ScratchSexpGenerator >> position [

	^ position
]

{ #category : 'accessing' }
ScratchSexpGenerator >> position: anObject [

	position := anObject
]

{ #category : 'private' }
ScratchSexpGenerator >> printChar: aCharacter [
	stream nextPut: aCharacter.
	position := position + 1
]

{ #category : 'private' }
ScratchSexpGenerator >> printCloseParen [
	stream nextPut: $).
	position := position + 1.
	indentLevel := indentLevel - 1
]

{ #category : 'private' }
ScratchSexpGenerator >> printLinefeed [
	stream nextPut: Character lf.
	position := 0
]

{ #category : 'private' }
ScratchSexpGenerator >> printOpenParen [
	wantsLinefeed
		ifTrue: [ wantsLinefeed := false.
			self printLinefeed.
			indentLevel > 0
				ifTrue: [ self printSpaces: (indents at: indentLevel) ] ].
	stream nextPut: $(.
	position := position + 1.
	indentLevel := indentLevel + 1.
	indents size < indentLevel
		ifTrue: [ indents := indents grownBy: indentLevel - indents size ].
	indents at: indentLevel put: position
]

{ #category : 'private' }
ScratchSexpGenerator >> printSpace [
	stream nextPut: Character space
]

{ #category : 'private' }
ScratchSexpGenerator >> printSpaces: anInteger [
	anInteger timesRepeat: [ stream nextPut: Character space ].
	position := position + anInteger
]

{ #category : 'private' }
ScratchSexpGenerator >> printString: aString [
	aString asString
		do: [ :c | 
			c = $(
				ifTrue: [ self printOpenParen ]
				ifFalse: [ c = $)
						ifTrue: [ self printCloseParen ]
						ifFalse: [ self printChar: c ] ] ]
]

{ #category : 'arg generator' }
ScratchSexpGenerator >> spriteArgString: aMorph [
	aMorph ifNil: [ self error ].
	^ aMorph objName
]

{ #category : 'accessing' }
ScratchSexpGenerator >> stream [

	^ stream
]

{ #category : 'accessing' }
ScratchSexpGenerator >> stream: anObject [

	stream := anObject
]

{ #category : 'code generator' }
ScratchSexpGenerator >> varNamesUsedIn: aMorph [

	^ #()
]

{ #category : 'arg generator' }
ScratchSexpGenerator >> variableArgString: aString [
	^ '(getVar ' , (SexpLexer quotedString: aString) , ')'
]

{ #category : 'accessing' }
ScratchSexpGenerator >> wantsLinefeed [

	^ wantsLinefeed
]

{ #category : 'accessing' }
ScratchSexpGenerator >> wantsLinefeed: anObject [

	wantsLinefeed := anObject
]

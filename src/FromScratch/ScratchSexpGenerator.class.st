Class {
	#name : #ScratchSexpGenerator,
	#superclass : #Object,
	#instVars : [
		'parser',
		'targetMorph',
		'stream'
	],
	#category : #'FromScratch-Converter'
}

{ #category : #'arg generator' }
ScratchSexpGenerator >> argString: anArgMorph [ 
	| v |
	^ anArgMorph labelMorph
		ifNil: [self error: 'nil arg']
		ifNotNil: 
			[v := anArgMorph evaluate.
			self literalStringFrom: v]
]

{ #category : #'arg generator' }
ScratchSexpGenerator >> eventTitleString: aString [
	^ aString
]

{ #category : #'arg generator' }
ScratchSexpGenerator >> expressionArgWithMenuString: aMorph [
	^ aMorph evaluate
]

{ #category : #'code generator' }
ScratchSexpGenerator >> generateBegin: aSymbol morph: aMorph [
	stream nextPut: $(.
	stream nextPutAll: aSymbol.
	aMorph blockArgs
		do: [ :each | 
			stream nextPut: Character space.
			stream nextPutAll: (each argString: parser) asString ].
	self generateLineFeed.
	stream nextPut: $(.
]

{ #category : #'code generator' }
ScratchSexpGenerator >> generateCenter: aSymbol morph: aMorph [
	stream nextPut: $).
	self generateLineFeed.
	stream nextPut: $(.
]

{ #category : #'code generator' }
ScratchSexpGenerator >> generateCode: aSymbol morph: aBlockMorph [
	stream nextPut: $(.
	stream nextPutAll: aSymbol.
	aBlockMorph blockArgs
		do: [ :each | 
			stream nextPut: Character space.
			stream nextPutAll: (each argString: parser) asString ].
	stream nextPut: $).
	self generateLineFeed.
]

{ #category : #'code generator' }
ScratchSexpGenerator >> generateEnd: aSymbol morph: aMorph [
	stream nextPutAll: '))'.
	self generateLineFeed.
]

{ #category : #'code generator' }
ScratchSexpGenerator >> generateEventFooter: aString [
	stream nextPutAll: '))'.
]

{ #category : #'code generator' }
ScratchSexpGenerator >> generateEventHeader: aString [
	self generateLineFeed.
	stream
		nextPutAll: '(when ';
		nextPutAll: aString.
	self generateLineFeed.
	stream nextPut: $(.
]

{ #category : #private }
ScratchSexpGenerator >> generateIndent: anInteger [ 
	"do nothing"
]

{ #category : #'code generator' }
ScratchSexpGenerator >> generateLineFeed [
	stream nextPut: Character lf.
]

{ #category : #'arg generator' }
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

{ #category : #'code generator' }
ScratchSexpGenerator >> generateSubFooter: aString [
	stream nextPutAll: '))'.
]

{ #category : #'code generator' }
ScratchSexpGenerator >> generateSubHeader: aString [
	self generateLineFeed.
	stream
		nextPutAll: '(sub ';
		nextPutAll: aString.
	self generateLineFeed.
	stream nextPut: $(.
]

{ #category : #'code generator' }
ScratchSexpGenerator >> indentLevelFor: aString [
	^ 2
]

{ #category : #initialization }
ScratchSexpGenerator >> initialize [
	super initialize.
	parser := ScratchBlockParser codeGenerator: self.
	stream := WriteStream on: String new.
]

{ #category : #'arg generator' }
ScratchSexpGenerator >> literalStringFrom: anObject [
	anObject isString
		ifTrue: [ ^ (SexpLexer quotedString: anObject) ].
	anObject isNumber
		ifTrue: [ ^ anObject ].
	self error.
]

{ #category : #accessing }
ScratchSexpGenerator >> parse: aTopBlock target: aMorph [
	targetMorph := aMorph.
	parser parseBlock: aTopBlock.
	^ stream contents
]

{ #category : #'arg generator' }
ScratchSexpGenerator >> spriteArgString: aMorph [
	aMorph ifNil: [ self error ].
	^ aMorph objName
]

{ #category : #'arg generator' }
ScratchSexpGenerator >> variableArgString: aString [
	^ '(getVar ' , (SexpLexer quotedString: aString) , ')'
]

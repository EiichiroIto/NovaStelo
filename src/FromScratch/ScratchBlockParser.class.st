Class {
	#name : #ScratchBlockParser,
	#superclass : #Object,
	#instVars : [
		'codeGenerator'
	],
	#category : #'FromScratch-Process'
}

{ #category : #accessing }
ScratchBlockParser class >> allSymbols [

	"self allSymbols inspect."

	| list |
	list := ScratchScript allSubclasses collect: [ :each | 
		        each new
			        setupBlockSpecs;
			        yourself ].
	list := list flatCollect: [ :each | 
		        each blockMorphBuilder blockSpecs ].
	list := list collect: [ :each | each selector ].
	list := list asSet.
	list := list asSortedCollection.
	^ list asArray
]

{ #category : #'instance creation' }
ScratchBlockParser class >> codeGenerator: aCodeGenerator [
	^ self basicNew
		privCodeGenerator: aCodeGenerator;
		yourself.
]

{ #category : #'instance creation' }
ScratchBlockParser class >> new [
	self shouldNotImplement
]

{ #category : #'arg generator' }
ScratchBlockParser >> argString: anArgMorph [ 
	^ codeGenerator argString: anArgMorph.
]

{ #category : #'arg generator' }
ScratchBlockParser >> booleanArgString: anArgMorph [ 
	^ codeGenerator falseString.
]

{ #category : #'arg generator' }
ScratchBlockParser >> choiceArgString: aMorph [
	^ codeGenerator choiceString: aMorph
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlock: aMorph indent: indent [
	self emitBlockCode: aMorph
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlockBegin: aMorph [ 
	codeGenerator generateBegin: aMorph selector morph: aMorph.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlockCenter: aMorph [ 
	codeGenerator generateCenter: aMorph selector morph: aMorph.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlockCode: aMorph [ 
	codeGenerator generateCode: aMorph selector morph: aMorph.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlockEnd: aMorph [ 
	codeGenerator generateEnd: aMorph selector morph: aMorph.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitCBlock: aMorph indent: indent [ 
	self emitBlockBegin: aMorph.
	aMorph nestedBlock ifNil: [self emitPassIndent: indent + 1]
		ifNotNil: [self emitCode: aMorph nestedBlock indent: indent + 1].
	self emitBlockEnd: aMorph.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitCode: aMorph indent: indent [ 
	self emitIndent: indent.
	aMorph emitCode: self indent: indent.
	aMorph nextBlock
		ifNotNil: [self
				emitCode: aMorph nextBlock
				indent: indent]
]

{ #category : #'code generator' }
ScratchBlockParser >> emitCodeHat: aHatBlock [
	aHatBlock emitCode: self indent: 0.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitEventHatBlock: aMorph indent: indent [
	| str |
	str := aMorph eventName.
	str isEmpty ifTrue: [^ self].
	codeGenerator generateEventHeader: str.
	aMorph nextBlock
		ifNotNil: [self
				emitCode: aMorph nextBlock
				indent: indent + (codeGenerator indentLevelFor: str)].
	codeGenerator generateEventFooter: str.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitIfElseBlock: aMorph indent: indent [ 
	self emitBlockBegin: aMorph.
	aMorph trueBlock ifNil: [self emitPassIndent: indent + 1]
		ifNotNil: [self emitCode: aMorph trueBlock indent: indent + 1].
	self emitIndent: indent.
	self emitBlockCenter: aMorph.
	aMorph falseBlock ifNil: [self emitPassIndent: indent + 1]
		ifNotNil: [self emitCode: aMorph falseBlock indent: indent + 1].
	self emitBlockEnd: aMorph.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitIndent: anInteger [
	codeGenerator generateIndent: anInteger
]

{ #category : #'code generator' }
ScratchBlockParser >> emitPassIndent: indent [
	self emitIndent: indent.
	codeGenerator generatePass.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitSubHatBlock: aMorph indent: indent [

	| str i2 |
	str := aMorph subName.
	str isEmpty ifTrue: [ ^ self ].
	codeGenerator generateSubHeader: str.
	i2 := indent + (codeGenerator indentLevelFor: str).
	aMorph nextBlock
		ifNil: [ 
			codeGenerator
				generateIndent: i2;
				generateEmptySubBody ]
		ifNotNil: [ 
			self emitSubVarDeclaration: aMorph indent: i2.
			self emitCode: aMorph nextBlock indent: i2 ].
	codeGenerator generateSubFooter: str
]

{ #category : #'code generator' }
ScratchBlockParser >> emitSubVarDeclaration: aMorph indent: indent [

	| list |
	list := codeGenerator varNamesUsedIn: aMorph.
	list isEmpty ifTrue: [ ^ self ].
	indent = 0 ifTrue: [ ^ self ].
	codeGenerator
		generateIndent: indent;
		generateSubVars: list
]

{ #category : #'arg generator' }
ScratchBlockParser >> eventTitleArgString: aMorph [
	^ codeGenerator eventTitleString: aMorph eventName
]

{ #category : #'arg generator' }
ScratchBlockParser >> expressionArgWithMenuString: t1 [ 
	^ codeGenerator expressionArgWithMenuString: t1
]

{ #category : #'arg generator' }
ScratchBlockParser >> localVarArgString: aVariableMorph [
	^ codeGenerator localVarArgString: aVariableMorph variable.
]

{ #category : #accessing }
ScratchBlockParser >> parseBlock: aTopBlock [
	aTopBlock emitCode: self indent: 0.
	aTopBlock isHatBlock
		ifFalse: [ aTopBlock nextBlock
				ifNotNil: [ self emitCode: aTopBlock nextBlock indent: 0 ] ]
]

{ #category : #accessing }
ScratchBlockParser >> parseReporter: aMorph [
	| str |
	str := self reporterArgString: aMorph.
	codeGenerator generateReporter: str
]

{ #category : #private }
ScratchBlockParser >> privCodeGenerator: aCodeGenerator [
	codeGenerator := aCodeGenerator.
]

{ #category : #'arg generator' }
ScratchBlockParser >> reporterArgString: aReporterMorph [

	^ codeGenerator generateReporter: aReporterMorph selector morph: aReporterMorph
]

{ #category : #'arg generator' }
ScratchBlockParser >> spriteArgString: aSpriteArgMorph [
	^ codeGenerator spriteArgString: aSpriteArgMorph evaluate
]

{ #category : #'arg generator' }
ScratchBlockParser >> valueString: aMorph [
	^ aMorph argString: self
]

{ #category : #'arg generator' }
ScratchBlockParser >> variableArgString: aVariableMorph [
	^ codeGenerator variableArgString: aVariableMorph variable.
]

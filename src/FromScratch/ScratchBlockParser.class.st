Class {
	#name : #ScratchBlockParser,
	#superclass : #Object,
	#instVars : [
		'generator'
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

{ #category : #'arg generator' }
ScratchBlockParser >> argString: anArgMorph [ 
	^ generator argString: anArgMorph.
]

{ #category : #'arg generator' }
ScratchBlockParser >> booleanArgString: anArgMorph [ 
	^ generator falseString.
]

{ #category : #'arg generator' }
ScratchBlockParser >> choiceArgString: aMorph [
	^ generator choiceString: aMorph
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlock: aMorph indent: indent [
	self emitBlockCode: aMorph
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlockBegin: aMorph [ 
	generator generateBegin: aMorph selector morph: aMorph.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlockCenter: aMorph [ 
	generator generateCenter: aMorph selector morph: aMorph.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlockCode: aMorph [ 
	generator generateCode: aMorph selector morph: aMorph.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitBlockEnd: aMorph [ 
	generator generateEnd: aMorph selector morph: aMorph.
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
	generator generateEventHeader: str.
	aMorph nextBlock
		ifNotNil: [self
				emitCode: aMorph nextBlock
				indent: indent + (generator indentLevelFor: aMorph)].
	generator generateEventFooter: str.
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
	generator generateIndent: anInteger
]

{ #category : #'code generator' }
ScratchBlockParser >> emitPassIndent: indent [
	self emitIndent: indent.
	generator generatePass.
]

{ #category : #'code generator' }
ScratchBlockParser >> emitStartHatBlock: aStartHatMorph indent: anInteger [

	| str |
	str := aStartHatMorph selector.
	str isEmpty ifTrue: [ ^ self ].
	generator generateEventHeader: str.
	aStartHatMorph nextBlock ifNotNil: [ 
		self
			emitCode: aStartHatMorph nextBlock
			indent: anInteger + (generator indentLevelFor: aStartHatMorph) ].
	generator generateEventFooter: str
]

{ #category : #'code generator' }
ScratchBlockParser >> emitSubHatBlock: aMorph indent: indent [

	| str i2 |
	str := aMorph subName.
	str isEmpty ifTrue: [ ^ self ].
	generator generateSubHeader: str.
	i2 := indent + (generator indentLevelFor: aMorph).
	aMorph nextBlock
		ifNil: [ 
			generator
				generateIndent: i2;
				generateEmptySubBody ]
		ifNotNil: [ 
			self emitSubVarDeclaration: aMorph indent: i2.
			self emitCode: aMorph nextBlock indent: i2 ].
	generator generateSubFooter: str
]

{ #category : #'code generator' }
ScratchBlockParser >> emitSubVarDeclaration: aMorph indent: indent [

	| list |
	list := generator varNamesUsedIn: aMorph.
	list isEmpty ifTrue: [ ^ self ].
	indent = 0 ifTrue: [ ^ self ].
	generator
		generateIndent: indent;
		generateSubVars: list
]

{ #category : #'arg generator' }
ScratchBlockParser >> eventTitleArgString: aMorph [
	^ generator eventTitleString: aMorph eventName
]

{ #category : #'arg generator' }
ScratchBlockParser >> expressionArgWithMenuString: t1 [ 
	^ generator expressionArgWithMenuString: t1
]

{ #category : #accessing }
ScratchBlockParser >> generator [

	^ generator
]

{ #category : #accessing }
ScratchBlockParser >> generator: aCodeGenerator [
	generator := aCodeGenerator.
]

{ #category : #'arg generator' }
ScratchBlockParser >> localVarArgString: aVariableMorph [
	^ generator localVarArgString: aVariableMorph variable.
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
	generator generateReporter: str
]

{ #category : #'arg generator' }
ScratchBlockParser >> reporterArgString: aReporterMorph [

	^ generator generateReporter: aReporterMorph selector morph: aReporterMorph
]

{ #category : #'arg generator' }
ScratchBlockParser >> spriteArgString: aSpriteArgMorph [
	^ generator spriteArgString: aSpriteArgMorph evaluate
]

{ #category : #'arg generator' }
ScratchBlockParser >> valueString: aMorph [
	^ aMorph argString: self
]

{ #category : #'arg generator' }
ScratchBlockParser >> variableArgString: aVariableMorph [
	^ generator variableArgString: aVariableMorph variable.
]

Class {
	#name : #ScratchCode,
	#superclass : #Object,
	#instVars : [
		'targetMorph',
		'bcGenerator',
		'parser'
	],
	#classVars : [
		'UsedCommands'
	],
	#category : #'FromScratch-Bytecode'
}

{ #category : #accessing }
ScratchCode class >> addCommand: aSymbol [
	UsedCommands add: aSymbol.
]

{ #category : #accessing }
ScratchCode class >> clearUsedCommands [
	"self clearUsedCommands"
	UsedCommands := Set new.
]

{ #category : #'class initialization' }
ScratchCode class >> initialize [
	self clearUsedCommands.
]

{ #category : #accessing }
ScratchCode class >> usedCommands [
	^ UsedCommands
]

{ #category : #'arithmetic ops' }
ScratchCode >> and: x with: y [
	^ bcGenerator
		and: [ x argString: parser ]
		with: [ y argString: parser ]
]

{ #category : #private }
ScratchCode >> argString: anArgMorph [ 
	| v |
	^ anArgMorph labelMorph
		ifNil: [0]
		ifNotNil: 
			[v := anArgMorph evaluate.
			self literalStringFrom: v]
]

{ #category : #'control ops' }
ScratchCode >> broadcast: msg [
	| eno |
	eno := msg argString: parser.
	eno ifNil: [ ^ self ].
	bcGenerator broadcast: eno
]

{ #category : #'control ops' }
ScratchCode >> callSub: subName [
	| str |
	str := subName choice.
	str isEmpty
		ifTrue: [ ^ self ].
	bcGenerator callSub: str.
]

{ #category : #'arithmetic ops' }
ScratchCode >> computeFunction: operator of: num [
	| op |
	op := operator choice.
	op = 'e ^'
		ifTrue: [ op := 'exp' ].
	op = '10 ^'
		ifTrue: [ op := 'exp10' ].
	^ bcGenerator
		computeFunction: op asSymbol
		of: [ num argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> computeFunctionof: aMorph [
	| op v |
	op := aMorph blockArgs first choice asSymbol.
	op = 'e ^'
		ifTrue: [ op := 'exp' ].
	op = '10 ^'
		ifTrue: [ op := 'exp10' ].
	v := [ aMorph blockArgs second argString: parser ].
	^ bcGenerator computeFunction: op asSymbol of: v
]

{ #category : #'basic ops' }
ScratchCode >> die [
	bcGenerator die.
]

{ #category : #'arithmetic ops' }
ScratchCode >> divide: x by: y [
	^ bcGenerator
		divide: [ x argString: parser ]
		by: [ y argString: parser ]
]

{ #category : #'control ops' }
ScratchCode >> doIfBegin: aMorph [
	| cond id |
	cond := aMorph blockArgs first argString: parser.
	id := bcGenerator doIfBegin: cond.
	aMorph labelId: id.
]

{ #category : #'control ops' }
ScratchCode >> doIfElseBegin: aMorph [
	self doIfBegin: aMorph.
]

{ #category : #'control ops' }
ScratchCode >> doIfElseCenter: aMorph [
	| orgId newId |
	orgId := aMorph labelId.
	newId := bcGenerator doIfElse: orgId.
	aMorph labelId: newId.
]

{ #category : #'control ops' }
ScratchCode >> doIfElseEnd: aMorph [
	self doIfEnd: aMorph.
]

{ #category : #'control ops' }
ScratchCode >> doIfEnd: aMorph [
	bcGenerator doIfEnd: aMorph labelId.
]

{ #category : #'control ops' }
ScratchCode >> doRepeatBegin: aMorph [
	| num labels |
	num := aMorph blockArgs first argString: parser.
	labels := bcGenerator doRepeatBegin: num.
	aMorph labelId: labels.
]

{ #category : #'control ops' }
ScratchCode >> doRepeatEnd: aMorph [
	bcGenerator doRepeatEndLabels: aMorph labelId.
]

{ #category : #'control ops' }
ScratchCode >> doUntilBegin: aMorph [
	| id |
	id := bcGenerator doUntilBegin.
	aMorph labelId: id.
]

{ #category : #'control ops' }
ScratchCode >> doUntilEnd: aMorph [
	| cond id |
	cond := aMorph blockArgs first argString: parser.
	id := aMorph labelId.
	bcGenerator doUntilEnd: cond id: id.
]

{ #category : #'arithmetic ops' }
ScratchCode >> equal: x to: y [
	^ bcGenerator
		equal: [ x argString: parser ]
		to: [ y argString: parser ]
]

{ #category : #private }
ScratchCode >> eventTitleString: aString [
	aString isEmpty ifTrue: [ ^ nil ].
	^ targetMorph project eventIdFor: aString asSymbol
]

{ #category : #private }
ScratchCode >> expressionArgWithMenuString: aMorph [
	^ aMorph evaluate
]

{ #category : #private }
ScratchCode >> falseString [
	^ false
]

{ #category : #'code generator' }
ScratchCode >> generateBegin: aSymbol morph: aMorph [
	| selector |
	selector := aSymbol copyWithout: $:.
	selector := (selector, 'Begin:') asSymbol.
	self perform: selector with: aMorph.
]

{ #category : #'code generator' }
ScratchCode >> generateCenter: aSymbol morph: aMorph [
	| selector |
	selector := aSymbol copyWithout: $:.
	selector := (selector, 'Center:') asSymbol.
	self perform: selector with: aMorph.
]

{ #category : #'code generator' }
ScratchCode >> generateCode: aSymbol morph: aMorph [
	self class addCommand: aSymbol.
	SpScratchApp
		try: [ self perform: aSymbol withArguments: aMorph blockArgs ]
		onFailure: [ aMorph showBalloon: 'error' ]
]

{ #category : #'code generator' }
ScratchCode >> generateEnd: aSymbol morph: aMorph [
	| selector |
	selector := aSymbol copyWithout: $:.
	selector := (selector, 'End:') asSymbol.
	self perform: selector with: aMorph.
]

{ #category : #'code generator' }
ScratchCode >> generateEventFooter: aString [ 
	bcGenerator stopThread.
]

{ #category : #'code generator' }
ScratchCode >> generateEventHeader: aString [
	"do nothing"
]

{ #category : #'code generator' }
ScratchCode >> generateIndent: anInteger [
	"do nothing"
]

{ #category : #'code generator' }
ScratchCode >> generatePass [
	"do nothing"
]

{ #category : #'code generator' }
ScratchCode >> generateReporter: aSymbol morph: aMorph [
	| ret |
	self class addCommand: aSymbol.
	ret := 0.
	SpScratchApp
		try: [ ret := self
				perform: aSymbol asSymbol
				withArguments: aMorph blockArgs ]
		onFailure: [ aMorph showBalloon: 'error' ].
	^ ret
]

{ #category : #'code generator' }
ScratchCode >> generateSubFooter: aString [ 
	bcGenerator return: 0.
]

{ #category : #'code generator' }
ScratchCode >> generateSubHeader: aString [
	"do nothing"
]

{ #category : #'sensing ops' }
ScratchCode >> getBreedId [
	^ bcGenerator getBreedId
]

{ #category : #'sensing ops' }
ScratchCode >> getId [
	^ bcGenerator getId
]

{ #category : #private }
ScratchCode >> indentLevelFor: aString [ 
	^ 0
]

{ #category : #initialization }
ScratchCode >> initialize [
	super initialize.
	parser := ScratchBlockParser codeGenerator: self.
]

{ #category : #'arithmetic ops' }
ScratchCode >> is: x between: from and: to [
	^ bcGenerator
		is: [ x argString: parser ]
		between: [ from argString: parser ]
		and: [ to argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> less: x than: y [
	^ bcGenerator
		less: [ x argString: parser ]
		than: [ y argString: parser ]
]

{ #category : #private }
ScratchCode >> literalStringFrom: anObject [
	anObject isString
		ifTrue: [ ^ anObject asNumberNoError ].
	anObject isNumber
		ifTrue: [ ^ anObject ].
	^ 0
]

{ #category : #'arithmetic ops' }
ScratchCode >> minus: x with: y [
	^ bcGenerator
		minus: [ x argString: parser ]
		with: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> mod: x by: y [
	^ bcGenerator
		mod: [ x argString: parser ]
		by: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> more: x than: y [
	^ bcGenerator
		less: [ y argString: parser ]
		than: [ x argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> multiply: x and: y [
	^ bcGenerator
		multiply: [ x argString: parser ]
		and: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> negated: x [
	^ bcGenerator minus: 0 with: [ x argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> not: x [
	^ bcGenerator not: (x argString: parser)
]

{ #category : #'arithmetic ops' }
ScratchCode >> or: x with: y [
	^ bcGenerator
		or: [ x argString: parser ]
		with: [ y argString: parser ]
]

{ #category : #accessing }
ScratchCode >> parse: aTopBlock target: aMorph [
	targetMorph := aMorph.
	parser parseBlock: aTopBlock.
	^ bcGenerator code.
]

{ #category : #'arithmetic ops' }
ScratchCode >> plus: x and: y [
	^ bcGenerator plus: [ x argString: parser ] and: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> randomFrom: a to: b [
	^ bcGenerator
		randomFrom: [ a argString: parser ]
		to: [ b argString: parser ]
]

{ #category : #'control ops' }
ScratchCode >> return: num [
	bcGenerator return: [ num argString: parser ].
]

{ #category : #'control ops' }
ScratchCode >> returnValue [
	^ bcGenerator returnValue
]

{ #category : #'arithmetic ops' }
ScratchCode >> rounded: x [
	^ bcGenerator rounded: (x argString: parser)
]

{ #category : #private }
ScratchCode >> spriteArgString: aMorph [
	^ aMorph breedNo
]

{ #category : #accessing }
ScratchCode >> startAddress: anInteger [
	bcGenerator address: anInteger.
]

{ #category : #'control ops' }
ScratchCode >> stopAll [
	bcGenerator stopAll.
]

{ #category : #'control ops' }
ScratchCode >> stopThread [
	bcGenerator stopThread.
]

{ #category : #accessing }
ScratchCode >> subTable: aDictionary [
	bcGenerator subTable: aDictionary.
]

{ #category : #'arithmetic ops' }
ScratchCode >> truncated: x [
	^ bcGenerator truncated: (x argString: parser)
]

{ #category : #private }
ScratchCode >> variableArgString: aString [
	| v |
	v := [ targetMorph varId varNoFor: aString ] ifError: [ nil ].
	v ifNil: [ ^ 0 ].
	^ bcGenerator getVar: v
]

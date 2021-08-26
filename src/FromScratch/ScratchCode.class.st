Class {
	#name : #ScratchCode,
	#superclass : #Object,
	#instVars : [
		'parser',
		'generator'
	],
	#classVars : [
		'UsedCommands'
	],
	#category : #'FromScratch-Process'
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
	^ generator
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
			generator literalStringFrom: v]
]

{ #category : #'arithmetic ops' }
ScratchCode >> bitAnd: x with: y [
	^ generator
		bitAnd: [ x argString: parser ]
		with: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> bitOr: x with: y [
	^ generator
		bitOr: [ x argString: parser ]
		with: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> bitShift: x left: y [
	^ generator
		bitShift: [ x argString: parser ]
		left: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> bitShift: x right: y [
	^ generator
		bitShift: [ x argString: parser ]
		right: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> bitXor: x with: y [
	^ generator
		bitXor: [ x argString: parser ]
		with: [ y argString: parser ]
]

{ #category : #'control ops' }
ScratchCode >> broadcast: msg [
	| eno |
	eno := msg argString: parser.
	eno ifNil: [ ^ self ].
	generator broadcast: eno
]

{ #category : #'control ops' }
ScratchCode >> callSub: subName [
	| str |
	str := subName choice.
	str isEmpty
		ifTrue: [ ^ self ].
	generator callSub: str.
]

{ #category : #private }
ScratchCode >> choiceString: aMorph [
	| v |
	v := aMorph choice.
	(v isString and: [ v isEmpty ])
		ifTrue: [ self error: 'Choice is empty!' ].
	^ v
]

{ #category : #'arithmetic ops' }
ScratchCode >> computeFunction: operator of: num [
	| op |
	op := operator choice.
	op = 'e ^'
		ifTrue: [ op := 'exp' ].
	op = '10 ^'
		ifTrue: [ op := 'exp10' ].
	^ generator
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
	^ generator computeFunction: op asSymbol of: v
]

{ #category : #'basic ops' }
ScratchCode >> die [
	generator die.
]

{ #category : #'arithmetic ops' }
ScratchCode >> divide: x by: y [
	^ generator
		divide: [ x argString: parser ]
		by: [ y argString: parser ]
]

{ #category : #'control ops' }
ScratchCode >> doIfBegin: aMorph [
	| cond id |
	cond := aMorph blockArgs first argString: parser.
	id := generator doIfBegin: cond.
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
	newId := generator doIfElse: orgId.
	aMorph labelId: newId.
]

{ #category : #'control ops' }
ScratchCode >> doIfElseEnd: aMorph [
	self doIfEnd: aMorph.
]

{ #category : #'control ops' }
ScratchCode >> doIfEnd: aMorph [
	generator doIfEnd: aMorph labelId.
]

{ #category : #'control ops' }
ScratchCode >> doRepeatBegin: aMorph [
	| num labels |
	num := aMorph blockArgs first argString: parser.
	labels := generator doRepeatBegin: num.
	aMorph labelId: labels.
]

{ #category : #'control ops' }
ScratchCode >> doRepeatEnd: aMorph [
	generator doRepeatEndLabels: aMorph labelId.
]

{ #category : #'control ops' }
ScratchCode >> doUntilBegin: aMorph [
	| id |
	id := generator doUntilBegin.
	aMorph labelId: id.
]

{ #category : #'control ops' }
ScratchCode >> doUntilEnd: aMorph [
	| cond id |
	cond := aMorph blockArgs first argString: parser.
	id := aMorph labelId.
	generator doUntilEnd: cond id: id.
]

{ #category : #'arithmetic ops' }
ScratchCode >> equal: x to: y [
	^ generator
		equal: [ x argString: parser ]
		to: [ y argString: parser ]
]

{ #category : #private }
ScratchCode >> eventTitleString: aString [
	self subclassResponsibility
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
		onFailure: [ aMorph showBalloon: 'Error!' localized ]
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
	generator stopThread.
]

{ #category : #'code generator' }
ScratchCode >> generateEventHeader: aString [
	"do nothing"
]

{ #category : #'code generator' }
ScratchCode >> generateGlobalVars: aCollection [
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
ScratchCode >> generateReporter: aString [
	self subclassResponsibility
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
		onFailure: [ aMorph showBalloon: 'Error!' localized ].
	^ ret
]

{ #category : #'code generator' }
ScratchCode >> generateSubFooter: aString [
	"do nothing"
]

{ #category : #'code generator' }
ScratchCode >> generateSubHeader: aString [
	"do nothing"
]

{ #category : #accessing }
ScratchCode >> generator [
	^ generator
]

{ #category : #accessing }
ScratchCode >> generator: aGenerator [
	generator := aGenerator
]

{ #category : #'sensing ops' }
ScratchCode >> getBreedId [
	^ generator getBreedId
]

{ #category : #'sensing ops' }
ScratchCode >> getId [
	^ generator getId
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
	^ generator
		is: [ x argString: parser ]
		between: [ from argString: parser ]
		and: [ to argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> less: x than: y [
	^ generator
		less: [ x argString: parser ]
		than: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> minus: x with: y [
	^ generator
		minus: [ x argString: parser ]
		with: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> mod: x by: y [
	^ generator
		mod: [ x argString: parser ]
		by: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> more: x than: y [
	^ generator
		less: [ y argString: parser ]
		than: [ x argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> multiply: x and: y [
	^ generator
		multiply: [ x argString: parser ]
		and: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> negated: x [
	^ generator minus: 0 with: [ x argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> not: x [
	^ generator not: (x argString: parser)
]

{ #category : #'arithmetic ops' }
ScratchCode >> or: x with: y [
	^ generator
		or: [ x argString: parser ]
		with: [ y argString: parser ]
]

{ #category : #accessing }
ScratchCode >> parse: aTopBlock [
	aTopBlock parseUsing: parser.
	^ generator code.
]

{ #category : #'arithmetic ops' }
ScratchCode >> plus: x and: y [
	^ generator plus: [ x argString: parser ] and: [ y argString: parser ]
]

{ #category : #'arithmetic ops' }
ScratchCode >> randomFrom: a to: b [
	^ generator
		randomFrom: [ a argString: parser ]
		to: [ b argString: parser ]
]

{ #category : #'control ops' }
ScratchCode >> return: num [
	generator return: [ num argString: parser ].
]

{ #category : #'control ops' }
ScratchCode >> returnValue [
	^ generator returnValue
]

{ #category : #'arithmetic ops' }
ScratchCode >> rounded: x [
	^ generator rounded: (x argString: parser)
]

{ #category : #private }
ScratchCode >> spriteArgString: aMorph [
	^ aMorph breedNo
]

{ #category : #accessing }
ScratchCode >> startAddress: anInteger [
	generator address: anInteger.
]

{ #category : #'control ops' }
ScratchCode >> stopAll [
	generator stopAll.
]

{ #category : #'control ops' }
ScratchCode >> stopThread [
	generator stopThread.
]

{ #category : #accessing }
ScratchCode >> subTable: aDictionary [
	generator subTable: aDictionary.
]

{ #category : #'arithmetic ops' }
ScratchCode >> truncated: x [
	^ generator truncated: (x argString: parser)
]

{ #category : #private }
ScratchCode >> variableArgString: aString [
	self subclassResponsibility
]

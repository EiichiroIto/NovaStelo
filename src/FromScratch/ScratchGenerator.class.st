Class {
	#name : 'ScratchGenerator',
	#superclass : 'Object',
	#instVars : [
		'parser'
	],
	#category : 'FromScratch-Process',
	#package : 'FromScratch',
	#tag : 'Process'
}

{ #category : 'arg generator' }
ScratchGenerator >> argString: anArgMorph [

	^ anArgMorph labelMorph
		  ifNil: [ 0 ]
		  ifNotNil: [ self literalStringFrom: anArgMorph evaluate ]
]

{ #category : 'arg generator' }
ScratchGenerator >> choiceString: aMorph [

	| v |
	v := aMorph choice.
	(v isString and: [ v isEmpty ])
		ifTrue: [ self error: 'Choice is empty!' ].
	^ v
]

{ #category : 'private' }
ScratchGenerator >> code [

	self subclassResponsibility
]

{ #category : 'arg generator' }
ScratchGenerator >> eventTitleString: aString [

	self subclassResponsibility
]

{ #category : 'arg generator' }
ScratchGenerator >> expressionArgWithMenuString: aMorph [

	^ aMorph evaluate
]

{ #category : 'arg generator' }
ScratchGenerator >> falseString [

	^ false
]

{ #category : 'code generator' }
ScratchGenerator >> generateBegin: aSymbol morph: aMorph [

	| selector |
	selector := aSymbol copyWithout: $:.
	selector := ('generate' , selector asCamelCase , 'Begin:') asSymbol.
	self perform: selector with: aMorph
]

{ #category : 'code generator' }
ScratchGenerator >> generateCenter: aSymbol morph: aMorph [

	| selector |
	selector := aSymbol copyWithout: $:.
	selector := ('generate' , selector asCamelCase , 'Center:') asSymbol.
	self perform: selector with: aMorph
]

{ #category : 'code generator' }
ScratchGenerator >> generateCode: aSymbol morph: aMorph [

	SpScratchApp
		try: [ self perform: aSymbol withArguments: aMorph blockArgs ]
		onFailure: [ aMorph showBalloon: 'Error!' localized ]
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoForeverBegin: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoForeverEnd: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoIfBegin: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoIfElseBegin: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoIfElseCenter: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoIfElseEnd: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoIfEnd: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoIterateBegin: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoIterateEnd: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoRepeatBegin: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoRepeatEnd: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoUntilBegin: aMorph [ 

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoUntilEnd: aMorph [ 

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoWhileBegin: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateDoWhileEnd: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateEmptySubBody [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateEnd: aSymbol morph: aMorph [

	| selector |
	selector := aSymbol copyWithout: $:.
	selector := ('generate' , selector asCamelCase , 'End:') asSymbol.
	self perform: selector with: aMorph
]

{ #category : 'code generator' }
ScratchGenerator >> generateEventFooter: aString [ 

	"self subclassResponsibility"
]

{ #category : 'code generator' }
ScratchGenerator >> generateEventHeader: aString [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateIndent: anInteger [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generatePass [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateReporter: aString [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateReporter: aSymbol morph: aMorph [

	| ret |
	ret := 0.
	SpScratchApp
		try: [ 
			ret := self
				       perform: aSymbol asSymbol
				       withArguments: aMorph blockArgs ]
		onFailure: [ aMorph showBalloon: 'Error!' localized ].
	^ ret
]

{ #category : 'code generator' }
ScratchGenerator >> generateSubFooter: aString [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateSubHeader: aString [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> generateSubVars: aCollection [

	self subclassResponsibility
]

{ #category : 'private' }
ScratchGenerator >> header [

	self subclassResponsibility
]

{ #category : 'private' }
ScratchGenerator >> indentLevelFor: aMorph [

	^ 0
]

{ #category : 'private' }
ScratchGenerator >> literalStringFrom: anObject [

	^ anObject asString
]

{ #category : 'api' }
ScratchGenerator >> parseBlock: aTopBlock [

	aTopBlock parseUsing: parser.
	^ self code
]

{ #category : 'api' }
ScratchGenerator >> parseHats: aCollection [

	| code |
	aCollection do: [ :each | each parseUsing: parser ].
	code := self code.
	^ self header , code
]

{ #category : 'accessing' }
ScratchGenerator >> parser [

	^ parser
]

{ #category : 'accessing' }
ScratchGenerator >> parser: anObject [

	parser := anObject.
	anObject generator: self
]

{ #category : 'arg generator' }
ScratchGenerator >> spriteArgString: aMorph [

	self subclassResponsibility
]

{ #category : 'code generator' }
ScratchGenerator >> varNamesUsedIn: aMorph [

	self subclassResponsibility
]

{ #category : 'arg generator' }
ScratchGenerator >> variableArgString: aString [

	self subclassResponsibility
]

Class {
	#name : 'SteloBytecodeGenerator',
	#superclass : 'ScratchBytecodeGenerator',
	#category : 'Stelo-Process',
	#package : 'Stelo',
	#tag : 'Process'
}

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> aimHigh: var [

	^ self
		  unaryCommand: #aimHigh
		  arg: (script varNoFor: var choice breed: SBreedId patchesBreedNo)
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> and: x with: y [

	^ self
		  binaryCommand: #and
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'list ops' }
SteloBytecodeGenerator >> append: anObject toList: aList [

	| vno |
	vno := aList choice.
	vno isEmpty ifTrue: [ self error ].
	self
		binaryCommand: #appendToList
		arg1: (script varNoFor: vno)
		arg2: [ anObject argString: parser ]
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> broadcast: msg [

	| eno |
	eno := msg argString: parser.
	eno ifNil: [ ^ self ].
	self unaryCommand: #broadcast arg: eno
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> callSub: subName [

	| str |
	str := subName choice.
	str isEmpty ifTrue: [ ^ self ].
	self appendCall: str
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> changeObserverVar: var by: num [

	| v |
	v := script varNoFor: var choice breed: SBreedId observerBreedNo.
	self appendValue: 1.
	self appendValue: 1.
	self appendValue: v.
	self appendValue: SBreedId observerBreedNo.
	self appendSymbol: #getBreedVar.
	self appendValue: [ num argString: parser ].
	self appendSymbol: #plus.
	self appendValue: v.
	self appendValue: SBreedId observerBreedNo.
	self appendSymbol: #setBreedVarTo
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> changePatchVar: var at: pno by: num [

	| v |
	v := script varNoFor: var choice breed: SBreedId patchesBreedNo.
	self appendValue: [ pno argString: parser ].
	self appendSymbol: #dup.
	self appendValue: v.
	self appendValue: SBreedId patchesBreedNo.
	self appendSymbol: #getBreedVar.
	self appendValue: [ num argString: parser ].
	self appendSymbol: #plus.
	self appendValue: v.
	self appendValue: SBreedId patchesBreedNo.
	self appendSymbol: #setBreedVarTo
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> changePatchVar: var by: num [

	self appendValue: [ num argString: parser ].
	self appendValue: (script varNoFor: var choice breed: SBreedId patchesBreedNo).
	self appendValue: SBreedId patchesBreedNo.
	self appendSymbol: #changeBreedVarBy
]

{ #category : 'variable ops' }
SteloBytecodeGenerator >> changeVar: var by: num [

	| v |
	v := var choice.
	v isEmpty ifTrue: [ self error ].
	self appendValue: (script varNoFor: v).
	self appendSymbol: #dup.
	self appendSymbol: #getVar.
	self appendValue: [ num argString: parser ].
	self appendSymbol: #plus.
	self appendSymbol: #setVarTo
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> changeXposBy: aNumber [

	self appendSymbol: #getX.
	self appendValue: [ aNumber argString: parser ].
	self appendSymbol: #plus.
	self appendSymbol: #setX
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> changeYposBy: aNumber [

	self appendSymbol: #getY.
	self appendValue: [ aNumber argString: parser ].
	self appendSymbol: #plus.
	self appendSymbol: #setY
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> clearAll [

	self unaryCommand: #clearBreed arg: SBreedId patchesBreedNo.
	self nullaryCommand: #clearTurtles
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> clearGraphics [

	self unaryCommand: #clearBreed arg: SBreedId patchesBreedNo
]

{ #category : 'list ops' }
SteloBytecodeGenerator >> clearList: aList [

	| v |
	v := aList choice.
	v isEmpty ifTrue: [ self error ].
	^ self unaryCommand: #clearList arg: (script varNoFor: v)
]

{ #category : 'plot ops' }
SteloBytecodeGenerator >> clearPlots [

	self nullaryCommand: #clearPlots
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> clearTurtle: bno [

	self unaryCommand: #clearBreed arg: [ bno argString: parser ]
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> clearTurtles [
	self nullaryCommand: #clearTurtles.
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorBlack [

	^ self colorOf: #black
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorBlue [

	^ self colorOf: #blue
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorBrown [

	^ self colorOf: #brown
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorCyan [

	^ self colorOf: #cyan
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorGray [

	^ self colorOf: #gray
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorGreen [

	^ self colorOf: #green
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorLime [

	^ self colorOf: #lime
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorMagenta [

	^ self colorOf: #magenta
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorOf: aSymbol [

	^ ColorList colorOf: aSymbol
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorOrange [

	^ self colorOf: #orange
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorPink [

	^ self colorOf: #pink
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorPurple [

	^ self colorOf: #purple
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorRandom [

	^ self
		  binaryCommand: #randomFromTo
		  arg1: 1
		  arg2: ColorList default size - 1
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorRed [

	^ self colorOf: #red
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorSky [

	^ self colorOf: #sky
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorTurquoise [

	^ self colorOf: #turquoise
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorWhite [

	^ self colorOf: #white
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> colorYellow [

	^ self colorOf: #yellow
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> computeFunction: aSymbol of: aNumber [

	| op |
	op := aSymbol choice.
	op = 'e ^' ifTrue: [ op := 'exp' ].
	op = '10 ^' ifTrue: [ op := 'exp10' ].
	^ self unaryCommand: op asSymbol arg: [ aNumber argString: parser ]
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> copyPatchVar: var to: var2 [

	self appendValue: (script varNoFor: var2 choice breed: SBreedId patchesBreedNo)..
	self appendValue: (script varNoFor: var choice breed: SBreedId patchesBreedNo).
	self appendValue: SBreedId patchesBreedNo.
	self appendSymbol: #copyBreedVarTo
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> createPatchesSize: anInteger [

	self unaryCommand: #createPatch arg: [ anInteger argString: parser ]
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> createTurtleSize: size breedId: bno [

	self
		binaryCommand: #createTurtles
		arg1: [ size argString: parser ]
		arg2: [ bno argString: parser ]
]

{ #category : 'list ops' }
SteloBytecodeGenerator >> deleteLine: anInteger ofList: aList [

	| v |
	v := aList choice.
	v isEmpty ifTrue: [ self error ].
	self
		binaryCommand: #deleteLineOfList
		arg1: (script varNoFor: v)
		arg2: [ anInteger argString: parser ]
]

{ #category : 'misc ops' }
SteloBytecodeGenerator >> die [
	self appendSymbol: #getBreedId.
	self appendSymbol: #getId.
	self appendSymbol: #kill.
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> diffuse4Var: var percentage: num [

	self
		binaryCommand: #diffuse4
		arg1: (script varNoFor: var choice breed: SBreedId patchesBreedNo)
		arg2: [ num argString: parser ]
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> diffuseVar: var percentage: num [

	self
		binaryCommand: #diffuse
		arg1: (script varNoFor: var choice breed: SBreedId patchesBreedNo)
		arg2: [ num argString: parser ]
]

{ #category : 'misc ops' }
SteloBytecodeGenerator >> directionTo: pno [

	self appendValue: (pno argString: parser).
	self appendSymbol: #xyOf.
	self appendSymbol: #swap.
	self appendSymbol: #getX.
	self appendSymbol: #minus.
	self appendSymbol: #swap.
	self appendSymbol: #getY.
	self appendSymbol: #minus.
	self appendSymbol: #direction.
	^ nil
]

{ #category : 'misc ops' }
SteloBytecodeGenerator >> distanceTo: pno [

	self appendValue: (pno argString: parser).
	self appendSymbol: #xyOf.
	self appendSymbol: #swap.
	self appendSymbol: #getX.
	self appendSymbol: #minus.
	self appendSymbol: #dup.
	self appendSymbol: #mul.
	self appendSymbol: #swap.
	self appendSymbol: #getY.
	self appendSymbol: #minus.
	self appendSymbol: #dup.
	self appendSymbol: #mul.
	self appendSymbol: #plus.
	self appendSymbol: #sqrt.
	^ nil
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> divide: x by: y [

	^ self
		  binaryCommand: #div
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> doIfBegin: cond [

	| id |
	id := labelId newNo.
	self appendValue: cond.
	self appendSymbol: #jumpIfFalse withJump: id.
	^ id
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> doIfElse: orgId [

	| newId |
	newId := labelId newNo.
	self appendSymbol: #jump withJump: newId.	
	self appendLabel: orgId.
	^ newId
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> doIfEnd: id [

	self appendLabel: id
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> doRepeatBegin: num [

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

{ #category : 'control ops' }
SteloBytecodeGenerator >> doRepeatEndLabels: aCollection [

	self appendSymbol: #dec.
	self appendSymbol: #jump withJump: aCollection first.
	self appendLabel: aCollection second.
	self appendSymbol: #drop
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> doUntilBegin [

	| id |
	id := labelId newNo.
	self appendLabel: id.
	^ id
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> doUntilEnd: cond id: id [

	self appendValue: cond.
	self appendSymbol: #jumpIfFalse withJump: id
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> dx [
	^ self nullaryCommand: #dx
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> dy [
	^ self nullaryCommand: #dy
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> equal: x to: y [

	^ self
		  binaryCommand: #equal
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> forward: num [

	self unaryCommand: #forward arg: [ num argString: parser ]
]

{ #category : 'sensing ops' }
SteloBytecodeGenerator >> front [

	self appendSymbol: #getX.
	self appendSymbol: #dx.
	self appendSymbol: #plus.
	self appendSymbol: #getY.
	self appendSymbol: #dy.
	self appendSymbol: #plus.
	self appendSymbol: #patchAt.
	^ nil
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoForeverBegin: aMorph [

	self shouldNotImplement
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoForeverEnd: aMorph [

	self shouldNotImplement
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoIfElseBegin: aMorph [

	self generateDoIfBegin: aMorph
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoIfElseCenter: aMorph [

	| orgId newId |
	orgId := aMorph labelId.
	newId := self doIfElse: orgId.
	aMorph labelId: newId
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoIfElseEnd: aMorph [

	self generateDoIfEnd: aMorph
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoIterateBegin: aMorph [

	self shouldNotImplement
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoIterateEnd: aMorph [

	self shouldNotImplement
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoRepeatBegin: aMorph [

	| num labels |
	num := aMorph blockArgs first argString: parser.
	labels := self doRepeatBegin: num.
	aMorph labelId: labels
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoRepeatEnd: aMorph [

	self doRepeatEndLabels: aMorph labelId
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoWhileBegin: aMorph [

	self shouldNotImplement
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateDoWhileEnd: aMorph [

	self shouldNotImplement
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateReporter: aString [

	"do nothing"
]

{ #category : 'code generator' }
SteloBytecodeGenerator >> generateSubFooter: aString [

	self unaryCommand: #return arg: 0
]

{ #category : 'code injection' }
SteloBytecodeGenerator >> getBreed: bno var: vno at: index [

	self appendValue: index.
	self appendValue: vno.
	self appendValue: bno.
	self appendSymbol: #getBreedVar.
	^ nil
]

{ #category : 'sensing ops' }
SteloBytecodeGenerator >> getBreedId [
	^ self nullaryCommand: #getBreedId.
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> getColor [

	^ self unaryCommand: #getVar arg: SObserverVarDef colorVarNo
]

{ #category : 'sensing ops' }
SteloBytecodeGenerator >> getHeading [

	^ self unaryCommand: #getVar arg: STurtlesVarDef headingVarNo
]

{ #category : 'sensing ops' }
SteloBytecodeGenerator >> getId [

	^ self nullaryCommand: #getId
]

{ #category : 'list ops' }
SteloBytecodeGenerator >> getLine: anInteger ofList: aList [

	| v |
	v := aList choice.
	v isEmpty ifTrue: [ self error ].
	^ self
		  binaryCommand: #getLineOfList
		  arg1: (script varNoFor: v)
		  arg2: [ anInteger argString: parser ]
]

{ #category : 'variable ops' }
SteloBytecodeGenerator >> getObserverVar: var [

	^ self
		  getBreed: SBreedId observerBreedNo
		  var: (script varNoFor: var choice breed: SBreedId observerBreedNo)
		  at: 1
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> getPatchColorAt: pno [

	^ self
		  getBreed: SBreedId patchesBreedNo
		  var: SPatchesVarDef colorVarNo
		  at: [ pno argString: parser ]
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> getPatchVar: var at: pno [

	^ self
		  getBreed: SBreedId patchesBreedNo
		  var: (script varNoFor: var choice breed: SBreedId patchesBreedNo)
		  at: [ pno argString: parser ]
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> getTurtle: tno breed: bno var: var [

	^ self
		  getVar: [ :b | script varNoFor: var choice breed: b ]
		  breedNo: [ bno argString: parser ]
		  at: [ tno argString: parser ]
]

{ #category : 'variable ops' }
SteloBytecodeGenerator >> getVar: var [

	^ self unaryCommand: #getVar arg: (script varNoFor: var choice)
]

{ #category : 'code injection' }
SteloBytecodeGenerator >> getVar: aBlock1 breedNo: aBlock2 at: index [

	| bno |
	self appendValue: index.
	bno := aBlock2 value.
	self appendValue: (aBlock1 value: bno).
	self appendValue: bno.
	self appendSymbol: #getBreedVar.
	^ nil
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> getXpos [
	^ self nullaryCommand: #getX
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> getYpos [
	^ self nullaryCommand: #getY
]

{ #category : 'misc ops' }
SteloBytecodeGenerator >> hatch [
	^ self nullaryCommand: #hatch.
]

{ #category : 'private' }
SteloBytecodeGenerator >> header [

	self shouldNotImplement
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> here [
	self appendSymbol: #getX.
	self appendSymbol: #getY.
	self appendSymbol: #patchAt.
	^ nil
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> is: x between: from and: to [

	self
		binaryCommand: #lessEqual
		arg1: [ from argString: parser ]
		arg2: [ x argString: parser ].
	self
		binaryCommand: #lessEqual
		arg1: [ x argString: parser ]
		arg2: [ to argString: parser ].
	self appendSymbol: #and.
	^ nil
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> isPenDown [

	self appendValue: 0.
	self unaryCommand: #getVar arg: STurtlesVarDef flagVarNo.
	self appendValue: 1 << STurtlesVarDef penDownFlagNo.
	self appendSymbol: #and.
	self appendSymbol: #less.
	^ nil
]

{ #category : 'misc ops' }
SteloBytecodeGenerator >> kill: index breed: bno [

	self
		binaryCommand: #kill
		arg1: [ bno argString: parser ]
		arg2: [ index argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> less: x than: y [

	^ self
		  binaryCommand: #less
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> lessEqual: x than: y [

	^ self
		  binaryCommand: #lessEqual
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'list ops' }
SteloBytecodeGenerator >> lineCountOfList: aList [

	| v |
	v := aList choice.
	v isEmpty ifTrue: [ self error ].
	^ self
		  unaryCommand: #lineCountOfList
		  arg: (script varNoFor: v)
]

{ #category : 'list ops' }
SteloBytecodeGenerator >> list: aList contains: anInteger [

	| v |
	v := aList choice.
	v isEmpty ifTrue: [ self error ].
	self
		binaryCommand: #listContains
		arg1: (script varNoFor: v)
		arg2: [ anInteger argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> minus: x with: y [

	^ self
		  binaryCommand: #minus
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> mod: x by: y [

	^ self
		  binaryCommand: #mod
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> more: x than: y [

	^ self
		  binaryCommand: #less
		  arg1: [ y argString: parser ]
		  arg2: [ x argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> moreEqual: x than: y [

	^ self
		  binaryCommand: #lessEqual
		  arg1: [ y argString: parser ]
		  arg2: [ x argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> multiply: x and: y [

	^ self
		  binaryCommand: #mul
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> multiplyVar: var by: num [

	self appendValue: [ num argString: parser ].
	self appendValue:
		(script varNoFor: var choice breed: SBreedId patchesBreedNo).
	self appendValue: SBreedId patchesBreedNo.
	self appendSymbol: #multiplyBreedVarBy
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> negated: x [

	^ self binaryCommand: #minus arg1: 0 arg2: [ x argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> not: x [

	^ self unaryCommand: #not arg: (x argString: parser)
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> nsum4Var: var to: var2 [

	self
		binaryCommand: #nsum4
		arg1: (script varNoFor: var choice breed: SBreedId patchesBreedNo)
		arg2: (script varNoFor: var2 choice breed: SBreedId patchesBreedNo)
]

{ #category : 'observer ops' }
SteloBytecodeGenerator >> nsumVar: var to: var2 [

	self
		binaryCommand: #nsum
		arg1: (script varNoFor: var choice breed: SBreedId patchesBreedNo)
		arg2: (script varNoFor: var2 choice breed: SBreedId patchesBreedNo)
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> or: x with: y [

	^ self
		  binaryCommand: #or
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> patchAtX: x y: y [

	^ self
		  binaryCommand: #patchAt
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> penDown [

	self penDown: true
]

{ #category : 'code injection' }
SteloBytecodeGenerator >> penDown: aBoolean [

	self appendValue: STurtlesVarDef flagVarNo.
	self unaryCommand: #getVar arg: STurtlesVarDef flagVarNo.
	self appendValue: 1 << STurtlesVarDef penDownFlagNo.
	aBoolean
		ifTrue: [ self appendSymbol: #or ]
		ifFalse: [ self appendSymbol: #inv.
			self appendSymbol: #and ].
	self appendSymbol: #setVarTo
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> penUp [

	self penDown: false
]

{ #category : 'plot ops' }
SteloBytecodeGenerator >> plot: anInteger color: color [

	self
		binaryCommand: #plotColor
		arg1: [ anInteger argString: parser ]
		arg2: [ color argString: parser ]
]

{ #category : 'plot ops' }
SteloBytecodeGenerator >> plot: anInteger data: aFloat [

	self
		binaryCommand: #plotData
		arg1: [ anInteger argString: parser ]
		arg2: [ aFloat argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> plus: x and: y [

	^ self
		  binaryCommand: #plus
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> randomFrom: x to: y [

	^ self
		  binaryCommand: #randomFromTo
		  arg1: [ x argString: parser ]
		  arg2: [ y argString: parser ]
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> relativeToR: aNumber theta: aNumber2 [

	| r theta |
	r := [ aNumber argString: parser ].
	theta := [ aNumber2 argString: parser ].
	self appendValue: r.
	self appendValue: theta.
	self appendSymbol: #cos.
	self appendSymbol: #mul.
	self appendSymbol: #getX.
	self appendSymbol: #plus.
	self appendValue: r.
	self appendValue: theta.
	self appendSymbol: #sin.
	self appendSymbol: #mul.
	self appendSymbol: #getY.
	self appendSymbol: #plus.
	self appendSymbol: #patchAt.
	^ nil
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> relativeToX: x y: y [

	self appendValue: [ x argString: parser ].
	self appendSymbol: #getX.
	self appendSymbol: #plus.
	self appendValue: [ y argString: parser ].
	self appendSymbol: #getY.
	self appendSymbol: #plus.
	self appendSymbol: #patchAt.
	^ nil
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> return: anInteger [

	self unaryCommand: #return arg: [ anInteger argString: parser ]
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> returnValue [

	^ self nullaryCommand: #returnValue
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> rounded: x [

	^ self unaryCommand: #rounded arg: (x argString: parser)
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> scalePatch: var color: color from: from to: to [

	self appendValue: (script varNoFor: var choice breed: SBreedId patchesBreedNo).
	self appendValue: [ color argString: parser ].
	self appendValue: [ from argString: parser ].
	self appendValue: [ to argString: parser ].
	self appendSymbol: #scaleColorFromTo	

]

{ #category : 'color ops' }
SteloBytecodeGenerator >> scaleValue: var color: color from: from to: to [

	| v |
	v := var choice.
	v isEmpty ifTrue: [ ^ self ].
	self appendValue: (script varNoFor: v).
	self appendValue: [ color argString: parser ].
	self appendValue: [ from argString: parser ].
	self appendValue: [ to argString: parser ].
	self appendSymbol: #scaleColorFromTo
]

{ #category : 'sensing ops' }
SteloBytecodeGenerator >> screenHeight [

	^ self
		  getBreed: SBreedId observerBreedNo
		  var: SObserverVarDef heightVarNo
		  at: 1
]

{ #category : 'sensing ops' }
SteloBytecodeGenerator >> screenWidth [

	^ self
		  getBreed: SBreedId observerBreedNo
		  var: SObserverVarDef widthVarNo
		  at: 1
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> setColor: color [

	self unaryCommand: #setColorTo arg: [ color argString: parser ]
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> setHeading: angle [

	self unaryCommand: #setHeading arg: [ angle argString: parser ]
]

{ #category : 'list ops' }
SteloBytecodeGenerator >> setLine: anInteger ofList: aList to: anObject [

	| v |
	v := aList choice.
	v isEmpty ifTrue: [ self error ].
	self appendValue: [ anInteger argString: parser ].
	self appendValue: [ anObject argString: parser ].
	self appendValue: (script varNoFor: v).
	self appendSymbol: #setLineOfListTo
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> setPatchColorAt: pos to: color [

	self appendValue: [ pos argString: parser ].
	self appendValue: [ color argString: parser ].
	self appendValue: SPatchesVarDef colorVarNo.
	self appendValue: SBreedId patchesBreedNo.
	self appendSymbol: #setBreedVarTo
]

{ #category : 'patch ops' }
SteloBytecodeGenerator >> setPatchVar: var at: index to: aNumber [

	self appendValue: [ index argString: parser ].
	self appendValue: [ aNumber argString: parser ].
	self appendValue:
		(script varNoFor: var choice breed: SBreedId patchesBreedNo).
	self appendValue: SBreedId patchesBreedNo.
	self appendSymbol: #setBreedVarTo
]

{ #category : 'plot ops' }
SteloBytecodeGenerator >> setPlotYMax: aNumber [

	self unaryCommand: #setPlotYMax arg: [ aNumber argString: parser ]
]

{ #category : 'plot ops' }
SteloBytecodeGenerator >> setPlotYMin: aNumber [

	self unaryCommand: #setPlotYMin arg: [ aNumber argString: parser ]
]

{ #category : 'misc ops' }
SteloBytecodeGenerator >> setRandomSeed: num [

	self unaryCommand: #setRandomSeed arg: [ num argString: parser ]
]

{ #category : 'variable ops' }
SteloBytecodeGenerator >> setVar: var to: num [

	| v |
	v := var choice.
	v isEmpty ifTrue: [ self error ].
	self
		binaryCommand: #setVarTo
		arg1: (script varNoFor: v)
		arg2: [ num argString: parser ]
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> setXpos: num [

	self unaryCommand: #setX arg: [ num argString: parser ]
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> setYpos: num [

	self unaryCommand: #setY arg: [ num argString: parser ]
]

{ #category : 'color ops' }
SteloBytecodeGenerator >> stamp [

	self unaryCommand: #getVar arg: STurtlesVarDef xVarNo.
	self unaryCommand: #getVar arg: STurtlesVarDef yVarNo.
	self appendSymbol: #patchAt.
	self unaryCommand: #getVar arg: STurtlesVarDef colorVarNo.
	self appendSymbol: #setPatchColorTo
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> stopAll [

	self nullaryCommand: #stopAll
]

{ #category : 'control ops' }
SteloBytecodeGenerator >> stopThread [

	self nullaryCommand: #stop
]

{ #category : 'sensing ops' }
SteloBytecodeGenerator >> ticks [

	^ self
		  getBreed: SBreedId observerBreedNo
		  var: SObserverVarDef ticksVarNo
		  at: 1
]

{ #category : 'arithmetic ops' }
SteloBytecodeGenerator >> truncated: x [

	^ self unaryCommand: #truncated arg: (x argString: parser)
]

{ #category : 'turtle  ops' }
SteloBytecodeGenerator >> turn: angle [

	self appendValue: [ angle argString: parser ].
	self unaryCommand: #getVar arg: STurtlesVarDef headingVarNo.
	self appendSymbol: #plus.
	self appendSymbol: #setHeading
]

{ #category : 'misc ops' }
SteloBytecodeGenerator >> turtle: bno at: pno [

	self appendValue: [ pno argString: parser ].
	self appendValue: [ bno argString: parser ].
	self appendSymbol: #turtleAt.
	^ nil
]

{ #category : 'sensing ops' }
SteloBytecodeGenerator >> turtlesCount: bno [

	^ self
		  getBreed: SBreedId observerBreedNo
		  var: SObserverVarDef countAliveVarNo
		  at: (bno argString: parser)
]

{ #category : 'arg generator' }
SteloBytecodeGenerator >> variableArgString: aString [

	| v |
	v := [ script varNoFor: aString ]
		     on: Error
		     do: [ nil ].
	v ifNil: [ ^ 0 ].
	^ self unaryCommand: #getVar arg: v
]

Class {
	#name : #ScratchNativeThread,
	#superclass : #Object,
	#instVars : [
		'stack',
		'pc',
		'codes',
		'id',
		'isRunning',
		'isTerminated',
		'retVal'
	],
	#classVars : [
		'OpTable'
	],
	#classInstVars : [
		'cachedSymbols'
	],
	#category : #'Microworld-Process'
}

{ #category : #private }
ScratchNativeThread class >> cachedSymbols [
	cachedSymbols ifNil: [ self setupCachedSymbols ].
	^ cachedSymbols
]

{ #category : #acccessing }
ScratchNativeThread class >> indexOfSymbol: aSymbol [
	^ (self cachedSymbols indexOf: aSymbol) - 1
]

{ #category : #'class initialization' }
ScratchNativeThread class >> initialize [
	"self initialize."
	self setupCachedSymbols.
	self setupOpTable.
]

{ #category : #private }
ScratchNativeThread class >> setupCachedSymbols [
	cachedSymbols := #(#push0 #push1 #pushShort #pushFloat) , self symbols
]

{ #category : #private }
ScratchNativeThread class >> setupOpTable [
	OpTable := Array new: cachedSymbols size.
	cachedSymbols
		withIndexDo: [ :each :index | OpTable at: index put: each ].
]

{ #category : #private }
ScratchNativeThread class >> symbols [
	| list |
	list := self allMethods.
	list := list select: [ :each | each category endsWith: 'ops' ].
	list := list collect: #selector.
	^ list sort
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> abs [
	| x |
	x := self pop.
	self push: x abs.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> acos [
	| x |
	x := self pop.
	self push: (x min: 1.0 max: -1.0) arcCos radiansToDegrees.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> and [
	| x y |
	x := self pop.
	y := self pop.
	self push: x & y.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> asin [
	| x |
	x := self pop.
	self push: (x min: 1.0 max: -1.0) arcSin radiansToDegrees.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> atan [
	| x |
	x := self pop.
	self push: (x min: 1.0 max: -1.0) arcTan radiansToDegrees.
]

{ #category : #'control ops' }
ScratchNativeThread >> call [
	| address |
	address := self pop.
	self push: pc.
	pc := address.
]

{ #category : #accessing }
ScratchNativeThread >> codes [
	^ codes
]

{ #category : #accessing }
ScratchNativeThread >> codes: anObject [
	codes := anObject
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> cos [
	| x |
	x := self pop.
	self push: x degreesToRadians cos.
]

{ #category : #'misc ops' }
ScratchNativeThread >> dec [
	| v |
	v := self pop.
	self push: v - 1.
]

{ #category : #'misc ops' }
ScratchNativeThread >> direction [
	| x y d |
	y := self pop.
	x := self pop.
	d := (x closeTo: 0)
		ifTrue: [ y < 0
				ifTrue: [ -90 ]
				ifFalse: [ 90 ] ]
		ifFalse: [ (x @ y) degrees ].
	self push: d.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> div [
	| x y |
	y := self pop.
	x := self pop.
	y = 0
		ifTrue: [ ^ self errorOccuered ].
	self push: x asFloat / y asFloat
]

{ #category : #private }
ScratchNativeThread >> doOneCycle [
	| code |
	isRunning := true.
	[ pc > codes size
		ifTrue: [ ^ self error ].
	code := codes at: pc.
	pc := pc + 1.
	self perform: code.
	isRunning ] whileTrue.
	^ false
]

{ #category : #'misc ops' }
ScratchNativeThread >> drop [
	self pop.
]

{ #category : #'misc ops' }
ScratchNativeThread >> dup [
	| v |
	v := self pop.
	self push: v.
	self push: v.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> equal [
	| x y |
	y := self pop.
	x := self pop.
	self push: (x closeTo: y).
]

{ #category : #private }
ScratchNativeThread >> errorOccuered [
	self stopAll.
]

{ #category : #accessing }
ScratchNativeThread >> evaluate: anInteger [
	self pc: anInteger.
	[ self doOneCycle ] whileTrue.
	^ self pop
]

{ #category : #accessing }
ScratchNativeThread >> execute: anInteger [
	self pc: anInteger.
	[ self doOneCycle ] whileTrue.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> exp [
	| x |
	x := self pop.
	self push: x exp.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> exp10 [
	| x |
	x := self pop.
	self push: (10.0 raisedTo: x).
]

{ #category : #'variable ops' }
ScratchNativeThread >> getId [
	self push: id.
]

{ #category : #initialization }
ScratchNativeThread >> initialize [
	super initialize.
	stack := OrderedCollection new.
	pc := 1.
	isRunning := false.
	isTerminated := false.
	retVal := 0.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> inv [
	| x |
	x := self pop.
	self push: (x bitXor: 16rFFFF).
]

{ #category : #testing }
ScratchNativeThread >> isRunning [
	^ isRunning
]

{ #category : #testing }
ScratchNativeThread >> isTerminated [
	^ isTerminated
]

{ #category : #'control ops' }
ScratchNativeThread >> jump [
	| address |
	address := self pop.
	pc := address.
]

{ #category : #'control ops' }
ScratchNativeThread >> jumpIfFalse [
	| address cond |
	address := self pop.
	cond := self pop.
	cond = 0
		ifTrue: [ pc := address ].
]

{ #category : #'control ops' }
ScratchNativeThread >> jumpIfTrue [
	| address cond |
	address := self pop.
	cond := self pop.
	cond = 0
		ifFalse: [ pc := address ].
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> less [
	| x y |
	y := self pop.
	x := self pop.
	self push: (x < y).
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> lessEqual [
	| x y |
	y := self pop.
	x := self pop.
	self push: (x <= y).
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> ln [
	| x |
	x := self pop.
	self push: x ln.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> log [
	| x |
	x := self pop.
	self push: x log.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> minus [
	| x y |
	y := self pop.
	x := self pop.
	self push: x - y.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> mod [
	| x y |
	y := self pop.
	x := self pop.
	y = 0
		ifTrue: [ ^ self errorOccuered ].
	self push: x \\ y.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> mul [
	| x y |
	y := self pop.
	x := self pop.
	self push: x * y.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> not [
	| x |
	x := self pop.
	self push: (x bitXor: 1).
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> or [
	| x y |
	x := self pop.
	y := self pop.
	self push: x | y.
]

{ #category : #accessing }
ScratchNativeThread >> pc [
	^ pc
]

{ #category : #accessing }
ScratchNativeThread >> pc: anInteger [
	pc := anInteger.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> plus [
	| x y |
	y := self pop.
	x := self pop.
	self push: x + y.
]

{ #category : #private }
ScratchNativeThread >> pop [
	^ stack removeLast
]

{ #category : #private }
ScratchNativeThread >> privId [
	^ id
]

{ #category : #private }
ScratchNativeThread >> privId: anInteger [
	id := anInteger
]

{ #category : #private }
ScratchNativeThread >> privIsRunning: aBoolean [
	isRunning := aBoolean.
]

{ #category : #private }
ScratchNativeThread >> privIsTerminated: aBoolean [
	isTerminated := aBoolean.
]

{ #category : #private }
ScratchNativeThread >> privRetVal: anInteger [
	retVal := anInteger.
]

{ #category : #private }
ScratchNativeThread >> push0 [
	self push: 0.
]

{ #category : #private }
ScratchNativeThread >> push1 [
	self push: 1.
]

{ #category : #private }
ScratchNativeThread >> push: anObject [
	| x |
	x := anObject.
	x = true
		ifTrue: [ x := 1 ].
	x = false
		ifTrue: [ x := 0 ].
	stack add: x.
]

{ #category : #private }
ScratchNativeThread >> pushFloat [
	| v |
	v := codes at: pc.
	pc := pc + 1.
	v := (codes at: pc) * 16r100 + v.
	pc := pc + 1.
	v := (codes at: pc) * 16r10000 + v.
	pc := pc + 1.
	v := (codes at: pc) * 16r1000000 + v.
	pc := pc + 1.
	v := Float fromIEEE32Bit: v.
	self push: v
]

{ #category : #private }
ScratchNativeThread >> pushShort [
	| v |
	v := codes at: pc.
	pc := pc + 1.
	v := (codes at: pc) * 16r100 + v.
	pc := pc + 1.
	v >= 16r8000
		ifTrue: [ v := v - 16r10000 ].
	^ self push: v
]

{ #category : #'misc ops' }
ScratchNativeThread >> randomFromTo [
	| to from result |
	to := self pop.
	from := self pop.
	result := (from to: to) atRandom.
	self push: result.
]

{ #category : #accessing }
ScratchNativeThread >> retVal [
	^ retVal
]

{ #category : #'control ops' }
ScratchNativeThread >> return [
	retVal := self pop.
	pc := self pop.
]

{ #category : #'control ops' }
ScratchNativeThread >> returnValue [
	self push: retVal.
]

{ #category : #'misc ops' }
ScratchNativeThread >> rot [
	| x1 x2 x3 |
	x1 := self pop.
	x2 := self pop.
	x3 := self pop.
	self push: x2.
	self push: x1.
	self push: x3
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> rounded [
	| x |
	x := self pop.
	self push: x rounded.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> sin [
	| x |
	x := self pop.
	self push: x degreesToRadians sin.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> sqrt [
	| x |
	x := self pop.
	x < 0
		ifTrue: [ ^ self errorOccuered ].
	self push: x sqrt.
]

{ #category : #accessing }
ScratchNativeThread >> stack [
	^ stack
]

{ #category : #'control ops' }
ScratchNativeThread >> stop [
	isRunning := false.
]

{ #category : #'control ops' }
ScratchNativeThread >> stopAll [
	isRunning := false.
	isTerminated := true.
]

{ #category : #'misc ops' }
ScratchNativeThread >> swap [
	| x y |
	x := self pop.
	y := self pop.
	self push: x.
	self push: y.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> tan [
	| x |
	x := self pop.
	self push: x degreesToRadians tan.
]

{ #category : #'arithmetic ops' }
ScratchNativeThread >> truncated [
	| x |
	x := self pop.
	self push: x truncated.
]

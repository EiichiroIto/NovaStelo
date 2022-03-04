"
A STurtlesTest is a test class for testing the behavior of STurtles
"
Class {
	#name : #STurtlesTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-accessing variable' }
STurtlesTest >> testAliveAt [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	self assert: ts countAlive equals: 2.
	ts aliveAt: 1 put: false.
	self assert: ts countAlive equals: 1.
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testAliveAtPut [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 3.
	self assert: ts countAlive equals: 3.
	ts aliveAt: 1 put: false.
	ts aliveAt: 2 put: false.
	self assert: ts countAlive equals: 1.
	ts aliveAt: 2 put: true.
	self assert: ts countAlive equals: 2.
]

{ #category : #'tests-accessing' }
STurtlesTest >> testBreedName [
	| ts |
	ts := STurtles new.
	ts breedNo: 5.
	self assert: ts breedName equals: 'Turtle5'.
	ts breedNo: 3.
	self assert: ts breedName equals: 'Turtle3'.
]

{ #category : #'tests-accessing' }
STurtlesTest >> testBreedNo [
	| ts |
	ts := STurtles new.
	self assert: ts breedNo isNil.
	ts breedNo: 3.
	self assert: ts breedNo equals: 3.
	ts breedNo: 4.
	self assert: ts breedNo equals: 4.
]

{ #category : #'tests-accessing' }
STurtlesTest >> testClear [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts create: 100.
	self assert: ts countAlive equals: 100.
	ts clear.
	self assert: ts countAlive equals: 0.
]

{ #category : #'tests-accessing' }
STurtlesTest >> testCopyTurtleFromTo [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts create: 2.
	ts xAt: 1 put: 2.
	ts yAt: 1 put: 3.
	ts headingAt: 1 put: 30.
	ts headingAt: 2 put: 60.
	self assert: (ts xAt: 1) equals: 2.
	self assert: (ts yAt: 1) equals: 3.
	self assert: (ts xAt: 2) equals: 0.
	self assert: (ts yAt: 2) equals: 0.
	self assert: (ts headingAt: 1) equals: 30.
	self assert: (ts headingAt: 2) equals: 60.
	ts copyTurtleFrom: 1 to: 2.
	self assert: (ts xAt: 1) equals: 2.
	self assert: (ts yAt: 1) equals: 3.
	self assert: (ts xAt: 2) equals: 2.
	self assert: (ts yAt: 2) equals: 3.
	self assert: (ts headingAt: 1) equals: 30.
	self assert: (ts headingAt: 2) equals: 30
]

{ #category : #'tests-accessing' }
STurtlesTest >> testCountAlive [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts create: 10.
	self assert: ts countAlive equals: 10.
	ts aliveAt: 4 put: false.
	ts aliveAt: 8 put: false.
	self assert: ts countAlive equals: 8.
]

{ #category : #'tests-command' }
STurtlesTest >> testCreate [
	| ts |
	ts := STurtles new breedNo: 3.
	self assert: ts countAlive equals: 0.
	ts create: 10.
	self assert: ts countAlive equals: 10.
]

{ #category : #'tests-accessing' }
STurtlesTest >> testDefaultColor [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	self assert: (ts defaultColor between: 1 and: 140).
]

{ #category : #'tests-accessing' }
STurtlesTest >> testDefaultPosition [
	| ts |
	ts := STurtles new.
	self assert: ts defaultPosition equals: 0 @ 0.
	ts defaultPosition: 10 @ 20.
	self assert: ts defaultPosition equals: 10 @ 20.
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testDeltaAt [
	| ts delta |
	ts := STurtles new breedNo: 3.
	ts create: 2.
	ts headingAt: 1 put: 30.
	ts headingAt: 2 put: 60.
	delta := ts deltaAt: 1.
	self assert: delta equals: (Point r: 1.0 degrees: 30).
	delta := ts deltaAt: 2.
	self assert: delta equals: (Point r: 1.0 degrees: 60).
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testHeadingAt [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	ts headingAt: 1 put: 10.
	ts headingAt: 2 put: 20.
	self assert: (ts headingAt: 1) equals: 10.
	self assert: (ts headingAt: 2) equals: 20
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testHeadingAtPut [
	self testHeadingAt.
]

{ #category : #'tests-initialization' }
STurtlesTest >> testInitialize [
	| ts |
	ts := STurtles new.
	self assert: ts varId class equals: STurtleVarDef.
	self assert: ts privVariables class equals: Variables.
	self assert: ts countAlive equals: 0.
]

{ #category : #'tests-enumerating' }
STurtlesTest >> testLivingOnesDo [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 5.
	self assert: ts countAlive equals: 5.
	ts livingOnesDo: [ :each | ts aliveAt: each put: false ].
	self assert: ts countAlive equals: 0.
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testPenDownAt [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	self assert: (ts penDownAt: 1) equals: false.
	self assert: (ts penDownAt: 2) equals: false.
	ts penDownAt: 1 put: true.
	ts penDownAt: 2 put: false.
	self assert: (ts penDownAt: 1) equals: true.
	self assert: (ts penDownAt: 2) equals: false
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testPenDownAtPut [
	self testPenDownAt.
]

{ #category : #'tests-printing' }
STurtlesTest >> testPrintOn [
	| ts |
	ts := STurtles new breedNo: 3.
	self assert: ts asString equals: 'Turtles(0)'.
	ts create: 10.
	self assert: ts asString equals: 'Turtles(10)'.
]

{ #category : #'tests-private' }
STurtlesTest >> testSetupAt [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts create: 3.
	ts setupAt: 1.
	ts setupAt: 2.
	ts setupAt: 3.
	self assert: (ts aliveAt: 1).
	self assert: (ts aliveAt: 2).
	self assert: (ts aliveAt: 3).
	self deny: (ts penDownAt: 1).
	self deny: (ts penDownAt: 2).
	self deny: (ts penDownAt: 3).
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testVarAtPut [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	ts var: STurtleVarDef xVarNo at: 1 put: 2.
	ts var: STurtleVarDef xVarNo at: 2 put: 5.
	ts var: STurtleVarDef headingVarNo at: 1 put: 200.
	ts var: STurtleVarDef headingVarNo at: 2 put: 400.
	ts var: STurtleVarDef colorVarNo at: 1 put: 100.
	ts var: STurtleVarDef colorVarNo at: 2 put: 200.
	self assert: (ts xAt: 1) equals: 2.
	self assert: (ts xAt: 2) equals: 5.
	self assert: (ts headingAt: 1) equals: 200.
	self assert: (ts headingAt: 2) equals: 40.
	self assert: (ts colorAt: 1) equals: 100.
	self assert: (ts colorAt: 2) equals: 200
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testXAt [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	self assert: (ts xAt: 1) equals: 0.
	self assert: (ts xAt: 2) equals: 0.
	ts xAt: 1 put: 10.
	ts xAt: 2 put: 20.
	self assert: (ts xAt: 1) equals: 10.
	self assert: (ts xAt: 2) equals: 20
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testXAtPut [
	self testXAt.
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testYAt [
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	self assert: (ts yAt: 1) equals: 0.
	self assert: (ts yAt: 2) equals: 0.
	ts yAt: 1 put: 10.
	ts yAt: 2 put: 20.
	self assert: (ts yAt: 1) equals: 10.
	self assert: (ts yAt: 2) equals: 20
]

{ #category : #'tests-accessing variable' }
STurtlesTest >> testYAtPut [
	self testYAt.
]

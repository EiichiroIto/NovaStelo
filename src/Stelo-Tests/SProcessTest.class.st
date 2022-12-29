"
A SProcessorTest is a test class for testing the behavior of SProcessor
"
Class {
	#name : #SProcessTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SProcessTest >> newWorld [
	| w |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	w addBreed: SPatches new.
	w newBreed.
	^ w
]

{ #category : #private }
SProcessTest >> sampleProgram3 [
	| program |
	program := SProgram new.
	program addCode: #(#pushShort 10 0 #pushShort 20 0 #stop).
	program addEntryPoint: 1 eventNo: 4 breedNo: 3.
	^ program
]

{ #category : #tests }
SProcessTest >> testAfterLoop [
	| p w |
	w := SMicroWorld new.
	p := w newProcess program: SProgram new.
	p privRunningEvents: #().
	p privTransition: #afterLoop.
	p afterLoop.
	self assert: p privTransition equals: #afterLoop.
	self assertCollection: p privRunningEvents equals: {EventId loopEventNo}.
	p privRunningEvents: #(8 9) asSet.
	p afterLoop.
	self assert: p privTransition equals: #afterLoop.
	self assert: (p privRunningEvents isKindOf: Set).
	self assert: p privRunningEvents size equals: 2.
	self assert: (p privRunningEvents includes: 8).
	self assert: (p privRunningEvents includes: 9).
]

{ #category : #tests }
SProcessTest >> testAfterSetup [
	| p w |
	w := SMicroWorld new.
	p := w newProcess program: SProgram new.
	p privRunningEvents: #().
	p privTransition: #afterSetup.
	p afterSetup.
	self assert: p privTransition equals: #idle.
	self assert: p privRunningEvents isEmpty.
	p privRunningEvents: #(8 9) asSet.
	p privTransition: #afterSetup.
	p afterSetup.
	self assert: p privTransition equals: #afterSetup.
	self assert: (p privRunningEvents isKindOf: Set).
	self assert: p privRunningEvents size equals: 2.
	self assert: (p privRunningEvents includes: 8).
	self assert: (p privRunningEvents includes: 9).
]

{ #category : #tests }
SProcessTest >> testAfterSingle [
	| p w |
	w := SMicroWorld new.
	p := w newProcess program: SProgram new.
	p privRunningEvents: #().
	p privTransition: #afterSingle.
	p afterSingle.
	self assert: p privTransition equals: #idle.
	self assert: p privRunningEvents isEmpty.
	p privRunningEvents: #(8 9) asSet.
	p privTransition: #afterSingle.
	p afterSingle.
	self assert: p privTransition equals: #afterSingle.
	self assert: (p privRunningEvents isKindOf: Set).
	self assert: p privRunningEvents size equals: 2.
	self assert: (p privRunningEvents includes: 8).
	self assert: (p privRunningEvents includes: 9).
]

{ #category : #tests }
SProcessTest >> testAfterStartup [
	| p w |
	w := SMicroWorld new.
	p := w newProcess program: SProgram new.
	p privRunningEvents: #().
	p privTransition: #afterStartup.
	p afterStartup.
	self assert: p privTransition equals: #afterSetup.
	self assertCollection: p privRunningEvents equals: {EventId setupEventNo}.
	p privRunningEvents: #(8 9) asSet.
	p privTransition: #afterStartup.
	p afterStartup.
	self assert: p privTransition equals: #afterStartup.
	self assert: (p privRunningEvents isKindOf: Set).
	self assert: p privRunningEvents size equals: 2.
	self assert: (p privRunningEvents includes: 8).
	self assert: (p privRunningEvents includes: 9).
]

{ #category : #tests }
SProcessTest >> testDoOneCycle [
	| w p ret |
	w := self newWorld.
	w createPatch: 1.
	w create: 3 turtles: 1.
	p := w newProcess program: self sampleProgram3.
	p privRunningEvents: {4}.
	ret := p doOneCycle.
	self assert: ret not.
]

{ #category : #tests }
SProcessTest >> testEvent [
	| w p |
	w := self newWorld.
	p := w newProcess.
	p event: 10.
	self assert: p privTransition equals: #afterSingle.
	self assertCollection: p privRunningEvents equals: {10}.
]

{ #category : #'tests-execution' }
SProcessTest >> testExecuteThreadBreedNoIndexIfTerminatedDo [
	| w prg p f x addr |
	w := self newWorld.
	prg := SProgram new.
	p := w newProcess program: prg.
	w create: 3 turtles: 1.
	w var: STurtleVarDef colorVarNo breed: 3 at: 1 put: ColorList black.
	addr := prg nextAddress.
	prg addCode: {#pushShort. ColorList white. 0. #setColorTo. #stop}.
	f := false.
	p executeThread: addr breedNo: 3 index: 1 ifTerminatedDo: [ f := true ].
	x := w var: STurtleVarDef colorVarNo breed: 3 at: 1.
	self assert: x equals: ColorList white.
	self deny: f.
	addr := prg nextAddress.
	prg addCode: {#stopAll}.
	p executeThread: addr breedNo: 3 index: 1 ifTerminatedDo: [ f := true ].
	self assert: f.
]

{ #category : #'tests-execution' }
SProcessTest >> testIdle [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p idle.
]

{ #category : #tests }
SProcessTest >> testInitialize [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p privTransition equals: #idle.
]

{ #category : #'tests-testing' }
SProcessTest >> testIsRunning [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p privTransition: #idle.
	self assert: p isRunning not.
	p privTransition: #loop.
	self assert: p isRunning.
	p privTransition: #setup.
]

{ #category : #'tests-accessing' }
SProcessTest >> testLoop [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p loop.
	self assert: p privTransition equals: #afterLoop.
	self assertCollection: p privRunningEvents equals: {EventId loopEventNo}.
]

{ #category : #'tests-private' }
SProcessTest >> testPrivRunningEvents [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p privRunningEvents isArray.
	self assert: p privRunningEvents isEmpty.
	p privRunningEvents: #(1 2 3).
	self assertCollection: p privRunningEvents equals: #(1 2 3).
]

{ #category : #'tests-private' }
SProcessTest >> testPrivTransition [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p privTransition equals: #idle.
	p privTransition: #abc.
	self assert: p privTransition equals: #abc.
]

{ #category : #'tests-accessing' }
SProcessTest >> testSetup [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p setup.
	self assert: p privTransition equals: #afterSetup.
	self assertCollection: p privRunningEvents equals: {EventId setupEventNo}.
]

{ #category : #'tests-accessing' }
SProcessTest >> testSingle [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p single.
	self assert: p privTransition equals: #afterSingle.
	self assertCollection: p privRunningEvents equals: {EventId singleEventNo}.
]

{ #category : #'tests-accessing' }
SProcessTest >> testStartup [
	| w p |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	p := w newProcess program: SProgram new.
	p startup.
	self assert: p privTransition equals: #afterStartup.
	self assertCollection: p privRunningEvents equals: {EventId startupEventNo}.
]

{ #category : #'tests-accessing' }
SProcessTest >> testStep [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p privTransition: #idle.
	p step.
]

{ #category : #'tests-execution' }
SProcessTest >> testStop [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p privTransition equals: #idle.
	self assert: p privRunningEvents isEmpty.
]

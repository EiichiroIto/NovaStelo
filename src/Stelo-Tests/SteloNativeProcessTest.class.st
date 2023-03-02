"
A SProcessorTest is a test class for testing the behavior of SProcessor
"
Class {
	#name : #SteloNativeProcessTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SteloNativeProcessTest >> newWorld [
	| w |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	w addBreed: SPatches new.
	w addNewTurtle.
	^ w
]

{ #category : #private }
SteloNativeProcessTest >> sampleProgram3 [
	| program |
	program := SProgram new.
	program addCode: #(#pushShort 10 0 #pushShort 20 0 #stop).
	program addEntryPoint: 1 eventNo: 4 breedNo: 3.
	^ program
]

{ #category : #tests }
SteloNativeProcessTest >> testAfterLoop [
	| p w |
	w := SMicroWorld new.
	p := w newProcess program: SProgram new.
	p runningEvents: #().
	p transition: #afterLoop.
	p afterLoop.
	self assert: p transition equals: #afterLoop.
	self assertCollection: p runningEvents equals: {EventId loopEventNo}.
	p runningEvents: #(8 9) asSet.
	p afterLoop.
	self assert: p transition equals: #afterLoop.
	self assert: (p runningEvents isKindOf: Set).
	self assert: p runningEvents size equals: 2.
	self assert: (p runningEvents includes: 8).
	self assert: (p runningEvents includes: 9).
]

{ #category : #tests }
SteloNativeProcessTest >> testAfterSetup [
	| p w |
	w := SMicroWorld new.
	p := w newProcess program: SProgram new.
	p runningEvents: #().
	p transition: #afterSetup.
	p afterSetup.
	self assert: p transition equals: #idle.
	self assert: p runningEvents isEmpty.
	p runningEvents: #(8 9) asSet.
	p transition: #afterSetup.
	p afterSetup.
	self assert: p transition equals: #afterSetup.
	self assert: (p runningEvents isKindOf: Set).
	self assert: p runningEvents size equals: 2.
	self assert: (p runningEvents includes: 8).
	self assert: (p runningEvents includes: 9).
]

{ #category : #tests }
SteloNativeProcessTest >> testAfterSingle [
	| p w |
	w := SMicroWorld new.
	p := w newProcess program: SProgram new.
	p runningEvents: #().
	p transition: #afterSingle.
	p afterSingle.
	self assert: p transition equals: #idle.
	self assert: p runningEvents isEmpty.
	p runningEvents: #(8 9) asSet.
	p transition: #afterSingle.
	p afterSingle.
	self assert: p transition equals: #afterSingle.
	self assert: (p runningEvents isKindOf: Set).
	self assert: p runningEvents size equals: 2.
	self assert: (p runningEvents includes: 8).
	self assert: (p runningEvents includes: 9).
]

{ #category : #tests }
SteloNativeProcessTest >> testAfterStartup [
	| p w |
	w := SMicroWorld new.
	p := w newProcess program: SProgram new.
	p runningEvents: #().
	p transition: #afterStartup.
	p afterStartup.
	self assert: p transition equals: #afterSetup.
	self assertCollection: p runningEvents equals: {EventId setupEventNo}.
	p runningEvents: #(8 9) asSet.
	p transition: #afterStartup.
	p afterStartup.
	self assert: p transition equals: #afterStartup.
	self assert: (p runningEvents isKindOf: Set).
	self assert: p runningEvents size equals: 2.
	self assert: (p runningEvents includes: 8).
	self assert: (p runningEvents includes: 9).
]

{ #category : #tests }
SteloNativeProcessTest >> testDoOneCycle [
	| w p ret |
	w := self newWorld.
	w createPatch: 1.
	w create: 3 turtles: 1.
	p := w newProcess program: self sampleProgram3.
	p runningEvents: {4}.
	ret := p doOneCycle.
	self assert: ret not.
]

{ #category : #tests }
SteloNativeProcessTest >> testEvent [
	| w p |
	w := self newWorld.
	p := w newProcess.
	p event: 10.
	self assert: p transition equals: #afterSingle.
	self assertCollection: p runningEvents equals: {10}.
]

{ #category : #'tests-execution' }
SteloNativeProcessTest >> testExecuteThreadBreedNoIndexIfTerminatedDo [
	| w prg p f x addr |
	w := self newWorld.
	prg := SProgram new.
	p := w newProcess program: prg.
	w create: 3 turtles: 1.
	w var: STurtlesVarDef colorVarNo breed: 3 at: 1 put: ColorList black.
	addr := prg nextAddress.
	prg addCode: {#pushShort. ColorList white. 0. #setColorTo. #stop}.
	f := false.
	p executeThread: addr breedNo: 3 index: 1 ifTerminatedDo: [ f := true ].
	x := w var: STurtlesVarDef colorVarNo breed: 3 at: 1.
	self assert: x equals: ColorList white.
	self deny: f.
	addr := prg nextAddress.
	prg addCode: {#stopAll}.
	p executeThread: addr breedNo: 3 index: 1 ifTerminatedDo: [ f := true ].
	self assert: f.
]

{ #category : #'tests-execution' }
SteloNativeProcessTest >> testIdle [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p idle.
]

{ #category : #tests }
SteloNativeProcessTest >> testInitialize [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p transition equals: #idle.
]

{ #category : #'tests-testing' }
SteloNativeProcessTest >> testIsRunning [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p transition: #idle.
	self assert: p isRunning not.
	p transition: #loop.
	self assert: p isRunning.
	p transition: #setup.
]

{ #category : #'tests-accessing' }
SteloNativeProcessTest >> testLoop [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p loop.
	self assert: p transition equals: #afterLoop.
	self assertCollection: p runningEvents equals: {EventId loopEventNo}.
]

{ #category : #'tests-private' }
SteloNativeProcessTest >> testRunningEvents [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p runningEvents isArray.
	self assert: p runningEvents isEmpty.
	p runningEvents: #(1 2 3).
	self assertCollection: p runningEvents equals: #(1 2 3).
]

{ #category : #'tests-accessing' }
SteloNativeProcessTest >> testSetup [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p setup.
	self assert: p transition equals: #afterSetup.
	self assertCollection: p runningEvents equals: {EventId setupEventNo}.
]

{ #category : #'tests-accessing' }
SteloNativeProcessTest >> testSingle [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p single.
	self assert: p transition equals: #afterSingle.
	self assertCollection: p runningEvents equals: {EventId singleEventNo}.
]

{ #category : #'tests-accessing' }
SteloNativeProcessTest >> testStartup [
	| w p |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	p := w newProcess program: SProgram new.
	p startup.
	self assert: p transition equals: #afterStartup.
	self assertCollection: p runningEvents equals: {EventId startupEventNo}.
]

{ #category : #'tests-accessing' }
SteloNativeProcessTest >> testStep [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p transition: #idle.
	p step.
]

{ #category : #'tests-execution' }
SteloNativeProcessTest >> testStop [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p transition equals: #idle.
	self assert: p runningEvents isEmpty.
]

{ #category : #'tests-private' }
SteloNativeProcessTest >> testTransition [
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p transition equals: #idle.
	p transition: #abc.
	self assert: p transition equals: #abc.
]

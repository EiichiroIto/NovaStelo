Class {
	#name : #ScratchNativeThreadTest,
	#superclass : #TestCase,
	#category : #'Microworld-Tests'
}

{ #category : #private }
ScratchNativeThreadTest >> newThread [
	^ ScratchNativeThread new
]

{ #category : #private }
ScratchNativeThreadTest >> sampleCode1 [
	^ OrderedCollection new
		add: #push1;
		add: #pushShort;
		add: 2;
		add: 0;
		add: #plus;
		add: #pushShort;
		add: 3;
		add: 0;
		add: #mul;
		add: #stop;
		yourself
]

{ #category : #private }
ScratchNativeThreadTest >> sampleCode2 [
	^ #(pushShort 1 0 pushShort 2 0 plus return pushShort 1 0 call returnValue dup mul stop)
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testAbs [
	| t |
	t := self newThread.
	t push: 10.
	self assert: t stack size equals: 1.
	t abs.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 10.
	t push: -20.
	self assert: t stack size equals: 1.
	t abs.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 20.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testAcos [
	| t |
	t := self newThread.
	t push: 0.5.
	self assert: t stack size equals: 1.
	t acos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 60.
	t push: -10.
	self assert: t stack size equals: 1.
	t acos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 180.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testAnd [
	| t |
	t := self newThread.
	t push: false.
	t push: false.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: false.
	t push: true.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: true.
	t push: false.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: true.
	t push: true.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testAsin [
	| t |
	t := self newThread.
	t push: 0.5.
	self assert: t stack size equals: 1.
	t asin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 30.
	t push: -10.
	self assert: t stack size equals: 1.
	t asin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -90.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testAtan [
	| t |
	t := self newThread.
	t push: 1.
	self assert: t stack size equals: 1.
	t atan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 45.
	t push: -10.
	self assert: t stack size equals: 1.
	t atan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -45.
]

{ #category : #'tests-control ops' }
ScratchNativeThreadTest >> testCall [
	| e |
	e := self newThread.
	e pc: 20.
	e push: 10.
	e call.
	self assert: e pc equals: 10.
	self assert: e stack size equals: 1.
	self assert: e pop equals: 20.
]

{ #category : #'tests-accessing' }
ScratchNativeThreadTest >> testCodes [
	| t |
	t := self newThread.
	self assert: t codes isNil.
	t codes: #(1 2 3).
	self assertCollection: t codes equals: #(1 2 3).
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testCos [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t cos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 90.
	self assert: t stack size equals: 1.
	t cos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 180.
	self assert: t stack size equals: 1.
	t cos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.
	t push: 270.
	self assert: t stack size equals: 1.
	t cos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testDec [
	| t |
	t := self newThread.
	t push: 10.
	self assert: t stack first equals: 10.
	t dec.
	self assert: t stack first equals: 9.
	t dec.
	self assert: t stack first equals: 8.
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testDirection [
	| t |
	t := self newThread.
	t push: 0.
	t push: 0.
	t direction.
	self assert: t pop equals: 90.
	t push: 1.
	t push: 1.
	t direction.
	self assert: t pop equals: 45.
	t push: 0.
	t push: 1.
	t direction.
	self assert: t pop equals: 90.
	t push: 0.
	t push: -1.
	t direction.
	self assert: t pop equals: -90.
	t push: -1.
	t push: 1.
	t direction.
	self assert: t pop equals: 135.
	t push: -1.
	t push: -1.
	t direction.
	self assert: t pop equals: 225.
	t push: 1.
	t push: -1.
	t direction.
	self assert: t pop equals: 360 - 45.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testDiv [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t div.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 2.
	t push: 5.
	t push: -10.
	self assert: t stack size equals: 2.
	t div.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -0.5.
	self deny: t isTerminated.
	t push: 5.
	t push: 0.
	t div.
	self assert: t isTerminated.
]

{ #category : #'tests-execution' }
ScratchNativeThreadTest >> testDoOneCycle [
	| e c |
	c := self sampleCode1.
	e := self newThread.
	e codes: c.
	self assert: e pc equals: 1.
	self assert: e stack isEmpty.
	self assert: e doOneCycle not.
	self assert: e pc equals: c size + 1.
	self assert: e stack size equals: 1.
	self assert: e stack first equals: 9.
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testDrop [
	| t |
	t := self newThread.
	self assert: t stack size equals: 0.
	t push: 10.
	self assert: t stack size equals: 1.
	t drop.
	self assert: t stack size equals: 0.
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testDup [
	| t |
	t := self newThread.
	self assert: t stack size equals: 0.
	t push: 10.
	self assert: t stack size equals: 1.
	t dup.
	self assert: t stack size equals: 2.
	self assert: t pop equals: 10.
	self assert: t pop equals: 10.
	self assert: t stack size equals: 0.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testEqual [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t equal.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -10.
	t push: -10.
	self assert: t stack size equals: 2.
	t equal.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #'tests-private' }
ScratchNativeThreadTest >> testErrorOccuered [
	| t |
	t := self newThread.
	self assert: t isTerminated equals: false.
	t errorOccuered.
	self assert: t isTerminated equals: true.
]

{ #category : #'tests-accessing' }
ScratchNativeThreadTest >> testEvaluate [
	| t c x |
	t := self newThread.
	c := #(push1 pushShort 2 0 #plus #stop).
	t codes: c.
	x := t evaluate: 1.
	self assert: x equals: 3.
]

{ #category : #'tests-accessing' }
ScratchNativeThreadTest >> testExecute [
	| t c |
	t := self newThread.
	c := #(push1 pushShort 2 0 #plus #stop).
	t codes: c.
	t execute: 1.
	self assert: t stack size equals: 1.
	self assert: t stack first equals: 3.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testExp [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t exp.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 2.
	self assert: t stack size equals: 1.
	t exp.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2 exp.
	t push: -1.
	self assert: t stack size equals: 1.
	t exp.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1 / 1 exp.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testExp10 [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t exp10.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 2.
	self assert: t stack size equals: 1.
	t exp10.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 100.
	t push: -1.
	self assert: t stack size equals: 1.
	t exp10.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.1.
]

{ #category : #'tests-variable ops' }
ScratchNativeThreadTest >> testGetId [
	| t |
	t := self newThread.
	t privId: 10.
	self assert: t stack size equals: 0.
	t getId.
	self assert: t pop equals: 10.
]

{ #category : #'tests-initialization' }
ScratchNativeThreadTest >> testInitialize [
	self testPc.
	self testStack.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testInv [
	| t |
	t := self newThread.
	t push: 0.
	t inv.
	self assert: t pop equals: 16rFFFF.
	t := self newThread.
	t push: 16rFFFF.
	t inv.
	self assert: t pop equals: 0.
	t := self newThread.
	t push: 16r1234.
	t inv.
	self assert: t pop equals: 16rEDCB.
]

{ #category : #'tests-testing' }
ScratchNativeThreadTest >> testIsRunning [
	self testPrivIsRunning.
]

{ #category : #'tests-testing' }
ScratchNativeThreadTest >> testIsTerminated [
	self testPrivIsTerminated.
]

{ #category : #'tests-control ops' }
ScratchNativeThreadTest >> testJump [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t push: 5.
	self assert: t stack size equals: 1.
	t jump.
	self assert: t pc equals: 5.
	self assert: t stack size equals: 0.
]

{ #category : #'tests-control ops' }
ScratchNativeThreadTest >> testJumpIfFalse [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t push: true.
	t push: 5.
	self assert: t stack size equals: 2.
	t jumpIfFalse.
	self assert: t pc equals: 1.
	self assert: t stack size equals: 0.
	t push: false.
	t push: 5.
	self assert: t stack size equals: 2.
	t jumpIfFalse.
	self assert: t pc equals: 5.
	self assert: t stack size equals: 0.
]

{ #category : #'tests-control ops' }
ScratchNativeThreadTest >> testJumpIfTrue [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t push: false.
	t push: 5.
	self assert: t stack size equals: 2.
	t jumpIfTrue.
	self assert: t pc equals: 1.
	self assert: t stack size equals: 0.
	t push: true.
	t push: 5.
	self assert: t stack size equals: 2.
	t jumpIfTrue.
	self assert: t pc equals: 5.
	self assert: t stack size equals: 0.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testLess [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t less.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -10.
	t push: -10.
	self assert: t stack size equals: 2.
	t less.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -10.
	t push: 10.
	self assert: t stack size equals: 2.
	t less.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testLessEqual [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t lessEqual.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -10.
	t push: -10.
	self assert: t stack size equals: 2.
	t lessEqual.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: -10.
	t push: 10.
	self assert: t stack size equals: 2.
	t lessEqual.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testLn [
	| t |
	t := self newThread.
	t push: 1.
	self assert: t stack size equals: 1.
	t ln.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 2 exp.
	self assert: t stack size equals: 1.
	t ln.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2.
	t push: 1 / 1 exp.
	self assert: t stack size equals: 1.
	t ln.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testLog [
	| t |
	t := self newThread.
	t push: 1.
	self assert: t stack size equals: 1.
	t log.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 100.
	self assert: t stack size equals: 1.
	t log.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2.
	t push: 0.1.
	self assert: t stack size equals: 1.
	t log.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testMinus [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t minus.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 5.
	t push: 5.
	t push: -10.
	self assert: t stack size equals: 2.
	t minus.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 15.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testMod [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t mod.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -5.
	t push: 10.
	self assert: t stack size equals: 2.
	t mod.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 5.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testMul [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t mul.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 50.
	t push: 0.5.
	t push: -10.
	self assert: t stack size equals: 2.
	t mul.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -5.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testNot [
	| t |
	t := self newThread.
	t push: false.
	self assert: t stack size equals: 1.
	t not.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: true.
	self assert: t stack size equals: 1.
	t not.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testOr [
	| t |
	t := self newThread.
	t push: false.
	t push: false.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t stack first equals: 0.
	t pop.
	t push: false.
	t push: true.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: true.
	t push: false.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: true.
	t push: true.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #'tests-accessing' }
ScratchNativeThreadTest >> testPc [
	| e |
	e := self newThread.
	self assert: e pc equals: 1.
	e pc: 10.
	self assert: e pc equals: 10.
	e pc: 20.
	self assert: e pc equals: 20.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testPlus [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t plus.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 15.
	t push: 5.
	t push: -10.
	self assert: t stack size equals: 2.
	t plus.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -5.
]

{ #category : #'tests-private' }
ScratchNativeThreadTest >> testPop [
	| e |
	e := self newThread.
	e push: 10.
	e push: 20.
	self assertCollection: e stack asArray equals: #(10 20).
	self assert: e pop equals: 20.
	self assert: e pop equals: 10.
	self assert: e stack isEmpty.
]

{ #category : #'tests-private' }
ScratchNativeThreadTest >> testPrivId [
	| e |
	e := self newThread.
	self assert: e privId isNil.
	e privId: 10.
	self assert: e privId equals: 10.
	e privId: 20.
	self assert: e privId equals: 20.
]

{ #category : #'tests-testing' }
ScratchNativeThreadTest >> testPrivIsRunning [
	| t |
	t := self newThread.
	self assert: t isRunning equals: false.
	t privIsRunning: true.
	self assert: t isRunning equals: true.
	t privIsRunning: false.
	self assert: t isRunning equals: false.
]

{ #category : #'tests-private' }
ScratchNativeThreadTest >> testPrivIsTerminated [
	| t |
	t := self newThread.
	self assert: t isTerminated equals: false.
	t privIsTerminated: true.
	self assert: t isTerminated equals: true.
	t privIsTerminated: false.
	self assert: t isTerminated equals: false.
]

{ #category : #'tests-private' }
ScratchNativeThreadTest >> testPrivRetVal [
	| t |
	t := self newThread.
	self assert: t retVal equals: 0.
	t privRetVal: 123.
	self assert: t retVal equals: 123.
]

{ #category : #'tests-private' }
ScratchNativeThreadTest >> testPush [
	| e |
	e := self newThread.
	self assert: e stack isEmpty.
	e push: 10.
	e push: 20.
	self assert: e stack size equals: 2.
	self assertCollection: e stack asArray equals: #(10 20).
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testPush0 [
	| e |
	e := self newThread.
	self assert: e stack isEmpty.
	e push0.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(0).
	e push0.
	self assert: e stack size equals: 2.
	self assertCollection: e stack asArray equals: #(0 0).
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testPush1 [
	| e |
	e := self newThread.
	self assert: e stack isEmpty.
	e push1.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(1).
	e push1.
	self assert: e stack size equals: 2.
	self assertCollection: e stack asArray equals: #(1 1).
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testPushFloat [
	| e |
	e := self newThread.
	e codes: #(16r00 16r00 16rF6 16r42).
	self assert: e stack isEmpty.
	e pushFloat.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(123.0)
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testPushShort [
	| e |
	e := self newThread.
	e codes: #(16r03 16r00).
	self assert: e stack isEmpty.
	e pushShort.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(3).
	e := self newThread.
	e codes: #(16rFD 16rFF).
	self assert: e stack isEmpty.
	e pushShort.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(-3)
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testRandomFromTo [
	| t |
	t := self newThread.
	100
		timesRepeat: [ self assert: t stack size equals: 0.
			t push: 5.
			t push: 10.
			t randomFromTo.
			self assert: t stack size equals: 1.
			self assert: (t pop between: 5 and: 10) ].
]

{ #category : #'tests-control ops' }
ScratchNativeThreadTest >> testRetVal [
	self testPrivRetVal.
]

{ #category : #'tests-control ops' }
ScratchNativeThreadTest >> testReturn [
	| e |
	e := self newThread.
	e pc: 20.
	e push: 30.
	e push: 10.
	e return.
	self assert: e pc equals: 30.
	self assert: e stack size equals: 0.
	self assert: e retVal equals: 10.
]

{ #category : #'tests-control ops' }
ScratchNativeThreadTest >> testReturnValue [
	| e c ret |
	c := self sampleCode2.
	e := self newThread.
	e codes: c.
	ret := e evaluate: 9.
	self assert: ret equals: 9.
	self assert: e stack isEmpty.
	self assert: e pc equals: c size + 1.
]

{ #category : #test }
ScratchNativeThreadTest >> testRot [
	| t |
	t := self newThread.
	self assert: t stack size equals: 0.
	t push: 10.
	t push: 20.
	t push: 30.
	self assert: t stack size equals: 3.
	t rot.
	self assert: t stack size equals: 3.
	self assert: t pop equals: 10.
	self assert: t pop equals: 30.
	self assert: t pop equals: 20.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testRounded [
	| t |
	t := self newThread.
	t push: 1.4.
	self assert: t stack size equals: 1.
	t rounded.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: 1.5.
	self assert: t stack size equals: 1.
	t rounded.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 2.
	t push: -1.5.
	self assert: t stack size equals: 1.
	t rounded.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -2.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testSin [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 90.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 180.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 270.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testSqrt [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t sqrt.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 2.
	self assert: t stack size equals: 1.
	t sqrt.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2 sqrt.
	self deny: t isTerminated.
	t push: -5.
	self assert: t stack size equals: 1.
	t sqrt.
	self assert: t isTerminated.
]

{ #category : #'tests-accessing' }
ScratchNativeThreadTest >> testStack [
	| e |
	e := self newThread.
	self assert: e stack isCollection.
	self assert: e stack isEmpty.
]

{ #category : #'tests-control ops' }
ScratchNativeThreadTest >> testStop [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t stop.
	self deny: t isRunning.
	self deny: t isTerminated.
]

{ #category : #'tests-control ops' }
ScratchNativeThreadTest >> testStopAll [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t stopAll.
	self deny: t isRunning.
	self assert: t isTerminated.
]

{ #category : #'tests-misc ops' }
ScratchNativeThreadTest >> testSwap [
	| t |
	t := self newThread.
	t push: 1.
	t push: 2.
	t swap.
	self assert: t pop equals: 1.
	self assert: t pop equals: 2.
]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testTan [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t tan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 60.
	self assert: t stack size equals: 1.
	t tan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 3 sqrt.
	t push: 30.
	self assert: t stack size equals: 1.
	t tan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: (1 / 3 sqrt).

]

{ #category : #'tests-arithmetic ops' }
ScratchNativeThreadTest >> testTruncated [
	| t |
	t := self newThread.
	t push: 1.4.
	self assert: t stack size equals: 1.
	t truncated.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: 1.5.
	self assert: t stack size equals: 1.
	t truncated.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: -1.5.
	self assert: t stack size equals: 1.
	t truncated.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -1.
]

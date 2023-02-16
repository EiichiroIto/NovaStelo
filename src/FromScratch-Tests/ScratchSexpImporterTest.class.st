"
A ScratchSexpImporterTest is a test class for testing the behavior of ScratchSexpImporter
"
Class {
	#name : #ScratchSexpImporterTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchSexpImporterTest >> newImporter [
	^ ScratchSexpImporter appName: 'test'
]

{ #category : #test }
ScratchSexpImporterTest >> testAppName [
	| i |
	i := self newImporter.
	self assert: i appName equals: 'test'.
	i appName: 'abc'.
	self assert: i appName equals: 'abc'
]

{ #category : #test }
ScratchSexpImporterTest >> testEvaluateArg [
	| i |
	i := self newImporter.
	self assert: (i evaluateArg: 'abc') equals: 'abc'.
	self assert: (i evaluateArg: '123') equals: 123.
	self assert: (i evaluateArg: '123x') equals: '123x'.
	self assert: (i evaluateArg: true) equals: true
]

{ #category : #test }
ScratchSexpImporterTest >> testEventBlockTupleFor [
	| i ret |
	i := self newImporter.
	ret := i eventBlockTupleFor: 'abc'.
	self assertCollection: ret equals: #(EventHatMorph abc)
]

{ #category : #test }
ScratchSexpImporterTest >> testGetVarTupleFrom [
	| i ret |
	i := self newImporter.
	ret := i getVarTupleFrom: #(getVar abc).
	self assertCollection: ret equals: #(readVariable abc)
]

{ #category : #test }
ScratchSexpImporterTest >> testOperatorTupleFrom [
	| i arr |
	i := self newImporter.
	arr := {'plus:and:' . '123' . 'x'}.
	arr := i operatorTupleFrom: arr.
	self assert: arr size equals: 3.
	self assert: arr first equals: #plus:and:.
	self assert: arr second equals: 123.
	self assert: arr third equals: 'x'
]

{ #category : #test }
ScratchSexpImporterTest >> testSetVarTupleFrom [
	| i ret |
	i := self newImporter.
	ret := i setVarTupleFrom: #(#setVar:to: life 1).
	self
		assertCollection: ret
		equals: #(changeVariable life #setVar:to: 1).
	ret := i setVarTupleFrom: #(#changeVar:by: energy -0.1).
	self
		assertCollection: ret
		equals: #(changeVariable energy #changeVar:by: -0.1)
]

{ #category : #test }
ScratchSexpImporterTest >> testSubBlockTupleFor [
	| i ret |
	i := self newImporter.
	ret := i subBlockTupleFor: 'abc'.
	self assertCollection: ret equals: #(SubHatMorph abc)
]

{ #category : #test }
ScratchSexpImporterTest >> testUpdateArgs [
	| i arr |
	i := self newImporter.
	arr := {'abc' . '123' . 'x'}.
	i updateArgs: arr.
	self assert: arr size equals: 3.
	self assert: arr first equals: #abc.
	self assert: arr second equals: 123.
	self assert: arr third equals: 'x'
]

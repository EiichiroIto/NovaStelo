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

{ #category : #private }
ScratchSexpImporterTest >> newScript [

	^ ScTestScript new
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
ScratchSexpImporterTest >> testEvaluateArgScript [
	| i script |
	i := self newImporter.
	script := self newScript.
	self assert: (i evaluateArg: 'abc' script: script) equals: 'abc'.
	self assert: (i evaluateArg: '123' script: script) equals: 123.
	self assert: (i evaluateArg: '123x' script: script) equals: '123x'.
	self assert: (i evaluateArg: true script: script) equals: true
]

{ #category : #test }
ScratchSexpImporterTest >> testEventBlockTupleFor [
	| i ret |
	i := self newImporter.
	ret := i eventBlockTupleFor: 'abc'.
	self assertCollection: ret equals: #(#EventHatMorph 'abc')
]

{ #category : #test }
ScratchSexpImporterTest >> testGetVarTupleFromScript [

	| i script ret |
	i := self newImporter.
	script := self newScript.
	ret := i getVarTupleFrom: #( getVar abc ) script: script.
	self assertCollection: ret equals: #( readVariable abc )
]

{ #category : #test }
ScratchSexpImporterTest >> testOperatorTupleFromScript [

	| i script arr |
	i := self newImporter.
	script := self newScript.
	arr := {'plus:and:' . '123' . 'x'}.
	arr := i operatorTupleFrom: arr script: script.
	self assert: arr size equals: 3.
	self assert: arr first equals: #plus:and:.
	self assert: arr second equals: 123.
	self assert: arr third equals: 'x'
]

{ #category : #test }
ScratchSexpImporterTest >> testSetVarTupleFromScript [

	| i script ret |
	i := self newImporter.
	script := self newScript.
	ret := i setVarTupleFrom: #(#setVar:to: life 1) script: script.
	self
		assertCollection: ret
		equals: #(changeVariable life #setVar:to: 1).
	ret := i setVarTupleFrom: #(#changeVar:by: energy -0.1) script: script.
	self
		assertCollection: ret
		equals: #(changeVariable energy #changeVar:by: -0.1)
]

{ #category : #test }
ScratchSexpImporterTest >> testStartBlockTupleFor [

	| i ret |
	i := self newImporter.
	ret := i startBlockTupleFor: 'abc'.
	self assertCollection: ret equals: #( #abc )
]

{ #category : #test }
ScratchSexpImporterTest >> testSubBlockTupleFor [
	| i ret |
	i := self newImporter.
	ret := i subBlockTupleFor: 'abc'.
	self assertCollection: ret equals: #(sub: abc)
]

{ #category : #test }
ScratchSexpImporterTest >> testUpdateArgsScript [
	| i script arr |
	i := self newImporter.
	script := self newScript.
	arr := {'abc' . '123' . 'x'}.
	i updateArgs: arr script: script.
	self assert: arr size equals: 3.
	self assert: arr first equals: #abc.
	self assert: arr second equals: 123.
	self assert: arr third equals: 'x'
]

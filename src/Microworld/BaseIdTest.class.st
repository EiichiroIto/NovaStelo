"
A SteloIdTest is a test class for testing the behavior of SteloId
"
Class {
	#name : 'BaseIdTest',
	#superclass : 'TestCase',
	#category : 'Microworld-Tests',
	#package : 'Microworld',
	#tag : 'Tests'
}

{ #category : 'private' }
BaseIdTest >> newBaseId [
	^ BaseId new
]

{ #category : 'test' }
BaseIdTest >> testInitialize [
	| e |
	e := self newBaseId.
	self assert: e privNextNo equals: e class defaultUserNo.
]

{ #category : 'test' }
BaseIdTest >> testNewNo [
	| e |
	e := self newBaseId.
	self assert: e privNextNo equals: e class defaultUserNo.
	e newNo.
	self assert: e privNextNo equals: e class defaultUserNo + 1.
	e newNo.
	self assert: e privNextNo equals: e class defaultUserNo + 2.
]

{ #category : 'test' }
BaseIdTest >> testPrivNextNo [
	| e |
	e := self newBaseId.
	e privNextNo: 10.
	self assert: e privNextNo equals: 10.
	e privNextNo: 20.
	self assert: e privNextNo equals: 20.
]

{ #category : 'test' }
BaseIdTest >> testRewind [
	| s |
	s := self newBaseId.
	self assert: s size equals: 0.
	5 timesRepeat: [s newNo].
	self assert: s size equals: 5.
	s rewind.
	self assert: s size equals: 0.
]

{ #category : 'test' }
BaseIdTest >> testSize [
	| e |
	e := self newBaseId.
	self assert: e size equals: e class reservedNo.
	e newNo.
	self assert: e size equals: e class reservedNo + 1.
]

{ #category : 'test' }
BaseIdTest >> testUserDefinedVarNos [
	| e |
	e := self newBaseId.
	self assertCollection: e userDefinedVarNos equals: #().
	e newNo.
	self assertCollection: e userDefinedVarNos equals: #(1).
	e newNo.
	self assertCollection: e userDefinedVarNos equals: #(1 2).
]

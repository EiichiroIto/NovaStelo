"
An EventHatMorphTest is a test class for testing the behavior of EventHatMorph
"
Class {
	#name : 'EventHatMorphTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
EventHatMorphTest >> newMorph [

	^ EventHatMorph new
]

{ #category : 'test' }
EventHatMorphTest >> testAsBlockTuple [

	| obj |
	obj := self newMorph.
	obj selector: #event:.
	obj eventName: 'abc'.
	self assertCollection: obj asBlockTuple equals: #( #event: 'abc' )
]

{ #category : 'test' }
EventHatMorphTest >> testCommandSpec [

	| obj |
	obj := self newMorph.
	self assert: obj commandSpec isString.
	obj commandSpec: 'abc'.
	self assert: obj commandSpec equals: 'abc'
]

{ #category : 'test' }
EventHatMorphTest >> testEventName [

	| obj |
	obj := self newMorph.
	self assert: obj eventName isEmpty.
	obj eventName: 'abc'.
	self assert: obj eventName equals: 'abc'.
	obj eventName: 'def'.
	self assert: obj eventName equals: 'def'
]

{ #category : 'test' }
EventHatMorphTest >> testInitialize [

	| obj |
	obj := self newMorph.
	self assert: obj eventName isEmpty
]

{ #category : 'test' }
EventHatMorphTest >> testNewLabelString [

	| obj |
	obj := self newMorph.
	self assert: (obj newLabelString isKindOf: StringMorph)
]

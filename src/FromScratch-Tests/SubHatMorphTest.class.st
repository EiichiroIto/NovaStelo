"
A SubHatMorphTest is a test class for testing the behavior of SubHatMorph
"
Class {
	#name : #SubHatMorphTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
SubHatMorphTest >> newMorph [

	^ SubHatMorph new
]

{ #category : #test }
SubHatMorphTest >> testAsBlockTuple [

	| obj |
	obj := self newMorph.
	obj selector: #abc:.
	obj subName: 'def'.
	self assertCollection: obj asBlockTuple equals: #( abc: 'def' )
]

{ #category : #test }
SubHatMorphTest >> testInitialize [

	| obj |
	obj := self newMorph.
	self assert: obj subName isEmpty
]

{ #category : #test }
SubHatMorphTest >> testSubName [

	| obj |
	obj := self newMorph.
	self assert: obj subName isEmpty.
	obj subName: 'abc'.
	self assert: obj subName equals: 'abc'.
	obj subName: 'def'.
	self assert: obj subName equals: 'def'
]

{ #category : #test }
SubHatMorphTest >> testVarNames [

	| obj |
	obj := self newMorph.
	obj receiver: ScTestScript new.
	self assertCollection: obj varNames hasSameElements: #( a 'b c' )
]

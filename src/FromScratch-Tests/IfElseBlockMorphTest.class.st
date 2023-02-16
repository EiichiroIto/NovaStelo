"
An IfElseBlockMorphTest is a test class for testing the behavior of IfElseBlockMorph
"
Class {
	#name : #IfElseBlockMorphTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
IfElseBlockMorphTest >> newBlock [

	^ IfElseBlockMorph new
]

{ #category : #test }
IfElseBlockMorphTest >> testFalseBlock [

	| b1 b2 |
	b1 := self newBlock.
	b2 := self newBlock.
	self assert: b1 falseBlock isNil.
	b1 falseBlock: b2.
	self assert: b1 falseBlock identicalTo: b2
]

{ #category : #test }
IfElseBlockMorphTest >> testNextOrInnerBlocks [

	| b1 b2 b3 b4 |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b4 := self newBlock.
	self assert: b1 nextOrInnerBlocks isArray.
	self assert: b1 nextOrInnerBlocks isEmpty.
	b1 nextBlock: b2.
	self assert: b1 nextOrInnerBlocks size equals: 1.
	self assert: b1 nextOrInnerBlocks first identicalTo: b2.
	b1 trueBlock: b3.
	self assert: b1 nextOrInnerBlocks size equals: 2.
	self assertCollection: b1 nextOrInnerBlocks hasSameElements: { 
			b2.
			b3 }.
	b1 falseBlock: b4.
	self assert: b1 nextOrInnerBlocks size equals: 3.
	self assertCollection: b1 nextOrInnerBlocks hasSameElements: { 
			b2.
			b3.
			b4 }
]

{ #category : #test }
IfElseBlockMorphTest >> testTrueBlock [

	| b1 b2 |
	b1 := self newBlock.
	b2 := self newBlock.
	self assert: b1 trueBlock isNil.
	b1 trueBlock: b2.
	self assert: b1 trueBlock identicalTo: b2
]

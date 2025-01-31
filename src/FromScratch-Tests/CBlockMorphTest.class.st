"
A CBlockMorphTest is a test class for testing the behavior of CBlockMorph
"
Class {
	#name : 'CBlockMorphTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
CBlockMorphTest >> newBlock [

	^ CBlockMorph new
]

{ #category : 'test' }
CBlockMorphTest >> testNestedBlock [

	| b1 b2 |
	b1 := self newBlock.
	b2 := self newBlock.
	self assert: b1 nestedBlock isNil.
	b1 nestedBlock: b2.
	self assert: b1 nestedBlock identicalTo: b2
]

{ #category : 'test' }
CBlockMorphTest >> testNextOrInnerBlocks [

	| b1 b2 b3 |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	self assert: b1 nextOrInnerBlocks isArray.
	self assert: b1 nextOrInnerBlocks isEmpty.
	b1 nextBlock: b2.
	self assert: b1 nextOrInnerBlocks size equals: 1.
	self assert: b1 nextOrInnerBlocks first identicalTo: b2.
	b1 nestedBlock: b3.
	self assert: b1 nextOrInnerBlocks size equals: 2.
	self assertCollection: b1 nextOrInnerBlocks hasSameElements: { 
			b2.
			b3 }
]

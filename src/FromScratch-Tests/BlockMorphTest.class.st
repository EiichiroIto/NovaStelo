"
A BlockMorphTest is a test class for testing the behavior of BlockMorph
"
Class {
	#name : #BlockMorphTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
BlockMorphTest >> newBlock [
	^ BlockMorph new
]

{ #category : #test }
BlockMorphTest >> testBlockAttachPoints [
	| b1 b2 b3 s |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	s := OrderedCollection new.
	b1 blockAttachPoints: s.
	self assert: s size equals: 4.
	self assert: (s allSatisfy: [:each | each isKindOf: Association]).
	self assert: (s allSatisfy: [:each | each key isPoint]).
	self assert: (s allSatisfy: [:each | each value isBlockMorph]).
	self assert: s first key equals: b1 topLeft.
	self assert: s second key equals: b1 bottomLeft.
	self assert: s third key equals: b2 topLeft.
	self assert: s fourth key equals: b3 topLeft
]

{ #category : #test }
BlockMorphTest >> testBlockPalette [
	| b1 b2 b3 s |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	self assert: b1 blockPalette isNil.
	self assert: b2 blockPalette isNil.
	self assert: b3 blockPalette isNil.
	s := ScratchBlockPaletteMorph new.
	s addMorph: b1.
	self assert: b1 blockPalette equals: s.
	self assert: b2 blockPalette equals: s.
	self assert: b3 blockPalette equals: s.
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	s := ScratchScriptsMorph new.
	s addMorph: b1.
	self assert: b1 blockPalette isNil.
	self assert: b2 blockPalette isNil.
	self assert: b3 blockPalette isNil
]

{ #category : #test }
BlockMorphTest >> testBlockSequence [
	| b1 b2 b3 |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	self
		assertCollection: b1 blockSequence
		equals:
			{b1.
			b2.
			b3}
]

{ #category : #test }
BlockMorphTest >> testBottomBlock [
	| b1 b2 b3 |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	self assert: b1 bottomBlock equals: b3
]

{ #category : #test }
BlockMorphTest >> testTopBlock [
	| b1 b2 b3 |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	self assert: b1 topBlock equals: b1.
	self assert: b2 topBlock equals: b1.
	self assert: b3 topBlock equals: b1
]

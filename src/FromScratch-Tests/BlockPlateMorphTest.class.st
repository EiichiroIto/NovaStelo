"
A BlockPlateMorphTest is a test class for testing the behavior of BlockPlateMorph
"
Class {
	#name : 'BlockPlateMorphTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
BlockPlateMorphTest >> newMorph [

	^ BlockPlateMorph new
]

{ #category : 'test' }
BlockPlateMorphTest >> testDraggingPoint [

	| morph |
	morph := self newMorph.
	self assert: morph draggingPoint isNil.
	morph draggingPoint: 1 @ 2.
	self assert: morph draggingPoint equals: 1 @ 2.
	morph draggingPoint: 3 @ 4.
	self assert: morph draggingPoint equals: 3 @ 4
]

{ #category : 'test' }
BlockPlateMorphTest >> testProject [

	| morph project |
	morph := self newMorph.
	self assert: morph project isNil.
	project := ScratchProject new.
	morph project: project.
	self assert: morph project identicalTo: project
]

{ #category : 'test' }
BlockPlateMorphTest >> testScreenshooting [

	| morph |
	morph := self newMorph.
	self deny: morph screenshooting.
	morph screenshooting: true.
	self assert: morph screenshooting.
	morph screenshooting: false.
	self deny: morph screenshooting
]

{ #category : 'test' }
BlockPlateMorphTest >> testScrollPoint [

	| morph |
	morph := self newMorph.
	self assert: morph scrollPoint isNil.
	morph scrollPoint: 1 @ 2.
	self assert: morph scrollPoint equals: 1 @ 2.
	morph scrollPoint: 3 @ 4.
	self assert: morph scrollPoint equals: 3 @ 4
]

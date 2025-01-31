"
A ScratchScriptTest is a test class for testing the behavior of ScratchScript
"
Class {
	#name : 'ScratchScriptTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
ScratchScriptTest >> newScript [
	^ ScratchScript new
]

{ #category : 'test' }
ScratchScriptTest >> testArgMorphBuilder [

	| obj a |
	obj := self newScript.
	self assert: obj argMorphBuilder isNil.
	a := ArgMorphBuilder new.
	obj argMorphBuilder: a.
	self assert: obj argMorphBuilder identicalTo: a
]

{ #category : 'test' }
ScratchScriptTest >> testBlockMorphBuilder [

	| script obj |
	script := self newScript.
	self assert: script blockMorphBuilder isNil.
	obj := BlockMorphBuilder new.
	script blockMorphBuilder: obj.
	self assert: script blockMorphBuilder identicalTo: obj
]

{ #category : 'test' }
ScratchScriptTest >> testBlocksBin [

	| script obj |
	script := self newScript.
	self assert: (script blocksBin isKindOf: ScratchScriptsMorph).
	obj := ScratchScriptsMorph new.
	script blocksBin: obj.
	self assert: script blocksBin identicalTo: obj
]

{ #category : 'test' }
ScratchScriptTest >> testCBlockSelectors [

	| script r |
	script := self newScript.
	r := script cBlockSelectors.
	self assert: r isArray.
	r do: [ :each | self assert: each isSymbol ]
]

{ #category : 'test' }
ScratchScriptTest >> testEvaluateFunctionWithArgs [
	| s |
	s := self newScript.
	self assert: (s evaluateFunction: #yourself withArgs: #()) equals: s
]

{ #category : 'test' }
ScratchScriptTest >> testForeverBlockSelectors [

	| script r |
	script := self newScript.
	r := script foreverBlockSelectors.
	self assert: r isArray.
	r do: [ :each | self assert: each isSymbol ]
]

{ #category : 'test' }
ScratchScriptTest >> testGetVarSelectors [

	| script r |
	script := self newScript.
	r := script getVarSelectors.
	self assert: r isArray.
	r do: [ :each | self assert: each isSymbol ]
]

{ #category : 'test' }
ScratchScriptTest >> testIfElseBlockSelectors [

	| script r |
	script := self newScript.
	r := script ifElseBlockSelectors.
	self assert: r isArray.
	r do: [ :each | self assert: each isSymbol ]
]

{ #category : 'test' }
ScratchScriptTest >> testInitialize [

	| script |
	script := self newScript.
	self assert: (script blocksBin isKindOf: ScratchScriptsMorph)
]

{ #category : 'test' }
ScratchScriptTest >> testLoopBlockSelectors [

	| script r |
	script := self newScript.
	r := script loopBlockSelectors.
	self assert: r isArray.
	r do: [ :each | self assert: each isSymbol ]
]

{ #category : 'test' }
ScratchScriptTest >> testNewArgMorphBuilder [

	| script obj |
	script := self newScript.
	obj := script newArgMorphBuilder.
	self assert: (obj isKindOf: ArgMorphBuilder)
]

{ #category : 'test' }
ScratchScriptTest >> testNewBlockMorphBuilder [

	| script obj |
	script := self newScript.
	obj := script newBlockMorphBuilder.
	self assert: (obj isKindOf: BlockMorphBuilder).
	self assert: obj script identicalTo: script
]

{ #category : 'test' }
ScratchScriptTest >> testNewBlockPaletteMorph [

	| script project obj |
	script := self newScript.
	project := ScratchProject new.
	script project: project.
	obj := script newBlockPaletteMorph.
	self assert: (obj isKindOf: ScratchBlockPaletteMorph).
	self assert: obj project identicalTo: project
]

{ #category : 'test' }
ScratchScriptTest >> testNewScriptsMorph [

	| script obj |
	script := self newScript.
	obj := script newScriptsMorph.
	self assert: (obj isKindOf: ScratchScriptsMorph)
]

{ #category : 'test' }
ScratchScriptTest >> testProject [

	| script obj |
	script := self newScript.
	self assert: script project isNil.
	obj := ScratchProject new.
	script project: obj.
	self assert: script project identicalTo: obj
]

{ #category : 'test' }
ScratchScriptTest >> testSetVarSelectors [

	| script r |
	script := self newScript.
	r := script setVarSelectors.
	self assert: r isArray.
	r do: [ :each | self assert: each isSymbol ]
]

{ #category : 'test' }
ScratchScriptTest >> testSpecialCommandSelectors [

	| script r |
	script := self newScript.
	r := script specialCommandSelectors.
	self assert: r isArray.
	r do: [ :each | self assert: each isSymbol ]
]

{ #category : 'test' }
ScratchScriptTest >> testStopBlockSelectors [

	| script r |
	script := self newScript.
	r := script stopBlockSelectors.
	self assert: r isArray.
	r do: [ :each | self assert: each isSymbol ]
]

{ #category : 'test' }
ScratchScriptTest >> testUseList [

	self assert: self newScript useList
]

{ #category : 'test' }
ScratchScriptTest >> testUseVariable [

	self assert: self newScript useVariable
]

{ #category : 'test' }
ScratchScriptTest >> testUseVariableWatcher [

	self assert: self newScript useVariableWatcher
]

{ #category : 'test' }
ScratchScriptTest >> testVariableBlockSelectors [

	| script r |
	script := self newScript.
	r := script variableBlockSelectors.
	self assert: r isArray.
	r do: [ :each | self assert: each isSymbol ]
]

{ #category : 'test' }
ScratchScriptTest >> testWatcherSelectors [

	self assert: self newScript watcherSelectors isEmpty
]

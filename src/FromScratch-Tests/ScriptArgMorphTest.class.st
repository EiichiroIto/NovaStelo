"
A ScriptArgMorphTest is a test class for testing the behavior of ScriptArgMorph
"
Class {
	#name : 'ScriptArgMorphTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
ScriptArgMorphTest >> newArgMorph [

	^ ScriptArgMorph new
]

{ #category : 'private' }
ScriptArgMorphTest >> newProject [

	^ ScratchProject new
]

{ #category : 'private' }
ScriptArgMorphTest >> newScript [

	^ ScTestScript new
]

{ #category : 'test' }
ScriptArgMorphTest >> testCheckForDeletedScript [

	| morph project script block |
	morph := self newArgMorph.
	project := self newProject.
	script := self newScript.
	script objName: 'abc'.
	block := ScTestBlock new project: project.
	morph privateOwner: block.
	morph defaultValue: script.
	self assert: morph selectedScript identicalTo: script.
	morph checkForDeletedScript.
	self assert: morph selectedScript isNil.
	project addScript: script.
	morph defaultValue: script.
	morph checkForDeletedScript.
	self assert: morph selectedScript identicalTo: script.
	morph defaultValue: 'def'.
	morph checkForDeletedScript.
	self assert: morph selectedScript isNil.
	morph defaultValue: 'abc'.
	morph checkForDeletedScript.
	self assert: morph selectedScript identicalTo: script
]

{ #category : 'test' }
ScriptArgMorphTest >> testDefaultValue [

	| morph |
	morph := self newArgMorph.
	self assert: morph selectedScript isNil.
	morph defaultValue: 'abc'.
	self assert: morph selectedScript equals: 'abc'
]

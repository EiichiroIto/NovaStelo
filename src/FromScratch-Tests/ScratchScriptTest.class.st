"
A ScratchScriptTest is a test class for testing the behavior of ScratchScript
"
Class {
	#name : #ScratchScriptTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchScriptTest >> newScript [
	^ ScratchScript new
]

{ #category : #test }
ScratchScriptTest >> testArgMorphBuilder [

	| obj a |
	obj := self newScript.
	self assert: obj argMorphBuilder isNil.
	a := ArgMorphBuilder new.
	obj argMorphBuilder: a.
	self assert: obj argMorphBuilder identicalTo: a
]

{ #category : #test }
ScratchScriptTest >> testEvaluateFunctionWithArgs [
	| s |
	s := self newScript.
	self assert: (s evaluateFunction: #yourself withArgs: #()) equals: s
]

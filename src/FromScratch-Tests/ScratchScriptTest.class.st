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
ScratchScriptTest >> testEvaluateFunctionWithArgs [
	| s |
	s := self newScript.
	self assert: (s evaluateFunction: #yourself withArgs: #()) equals: s
]

{ #category : #test }
ScratchScriptTest >> testEvaluateInfixWithArgs [
	| s |
	s := self newScript.
	self assert: (s evaluateInfix: #= withArgs: #('true' true)).
	self assert: (s evaluateInfix: #= withArgs: #('false' false)).
	self assert: (s evaluateInfix: #= withArgs: #(true 'true')).
	self assert: (s evaluateInfix: #= withArgs: #(false 'false')).
	self deny: (s evaluateInfix: #= withArgs: #('true' false)).
	self deny: (s evaluateInfix: #= withArgs: #('false' true)).
	self deny: (s evaluateInfix: #= withArgs: #(false 'true')).
	self deny: (s evaluateInfix: #= withArgs: #(true 'false')).
	self assert: (s evaluateInfix: #< withArgs: #(1 2)).
	self deny: (s evaluateInfix: #< withArgs: #(1 1)).
	self assert: (s evaluateInfix: #< withArgs: #('3' '12')).
	self deny: (s evaluateInfix: #< withArgs: #('12' '12')).
	self assert: (s evaluateInfix: #< withArgs: #('a' 'b')).
	self deny: (s evaluateInfix: #< withArgs: #('a' 'a')).
]

{ #category : #test }
ScratchScriptTest >> testPrivBlockDef [
	| script |
	script := self newScript.
	self assert: script privBlockDef isNil.
	script blockDef.
	self assert: script privBlockDef class equals: ScratchBlockDef
]

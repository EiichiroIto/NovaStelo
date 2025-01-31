"
A CommandBlockMorphTest is a test class for testing the behavior of CommandBlockMorph
"
Class {
	#name : 'CommandBlockMorphTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
CommandBlockMorphTest >> newBlock [
	^ CommandBlockMorph new
]

{ #category : 'private' }
CommandBlockMorphTest >> newScript [
	^ ScTestScript new
		setupBlockSpecs;
		yourself
]

{ #category : 'private' }
CommandBlockMorphTest >> newTestScript [
	^ ScTestScript new
		setupBlockSpecs;
		yourself
]

{ #category : 'test' }
CommandBlockMorphTest >> testArgPermutationForSpecWithTranslation [

	| r |
	r := CommandBlockMorph
		     argPermutationForSpec: '%a of %m of %m of %t'
		     withTranslation: '%a de %m de %m de %t'.
	self assertCollection: r equals: #( 1 2 3 4 ).
	r := CommandBlockMorph
		     argPermutationForSpec: '%a of %m of %m of %t'
		     withTranslation: '%t de %m2 de %m1 de %a'.
	self assertCollection: r equals: #( 4 3 2 1 ).
	self
		should: [ 
			CommandBlockMorph
				argPermutationForSpec: 'abc %n'
				withTranslation: 'abc %s' ]
		raise: Error.
	self
		should: [ 
			CommandBlockMorph
				argPermutationForSpec: 'abc %n'
				withTranslation: 'abc n' ]
		raise: Error
]

{ #category : 'test' }
CommandBlockMorphTest >> testArgSpecs [
	| b |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b commandSpec: 'abc %s def %n ghi %m'.
	self assertCollection: b argSpecs equals: #('%s' '%n' '%m')
]

{ #category : 'test' }
CommandBlockMorphTest >> testAsBlockTuple [
	| b ret |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b selector: #abc:def:.
	b commandSpec: 'abc %n def %s ghi'.
	ret := b asBlockTuple.
	self assertCollection: ret equals: #(#abc:def: 10 '').
	b argPermutation: #(1 2).
	(b argumentAt: 1) numExpression: 5.
	(b argumentAt: 2) stringExpression: 'a'.
	ret := b asBlockTuple.
	self assertCollection: ret equals: #(#abc:def: 5 'a')
]

{ #category : 'test' }
CommandBlockMorphTest >> testBlockSpec [

	| script block blockSpec |
	script := self newScript.
	block := self newBlock.
	block selector: #abs:.
	block receiver: script.
	blockSpec := block blockSpec.
	self assert: (blockSpec isKindOf: ScratchBlockSpec).
	self assert: blockSpec selector equals: #abs:.
	self assert: blockSpec label equals: 'abs %n'
]

{ #category : 'test' }
CommandBlockMorphTest >> testCoerceArgs [
	| b ret |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b selector: #abc:def:.
	b commandSpec: 'abc %n def %s ghi %n'.
	ret := b coerceArgs: #('20.0' 'abc' 30).
	self assertCollection: ret equals: #(20 'abc' 30).
	b selector: #setVar:to:.
	ret := b coerceArgs: #('20.0' 'abc' 30).
	self assertCollection: ret equals: #('20.0' 'abc' 30)
]

{ #category : 'test' }
CommandBlockMorphTest >> testDefaultArgs [
	| b |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b selector: #abc:def:.
	b commandSpec: 'abc %n def %s ghi'.
	b argPermutation: #(2 1).
	self assert: (b argumentAt: 1) evaluate equals: ''.
	self assert: (b argumentAt: 2) evaluate equals: 10.
	b defaultArgs: #('def').
	self assert: (b argumentAt: 1) evaluate equals: 'def'.
	self assert: (b argumentAt: 2) evaluate equals: 10.
	b defaultArgs: #('abc' 1).
	self assert: (b argumentAt: 1) evaluate equals: 'abc'.
	self assert: (b argumentAt: 2) evaluate equals: 1
]

{ #category : 'test' }
CommandBlockMorphTest >> testEvaluate [
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs:.
	b argPermutation: #(1).
	b defaultArgs: #(-5).
	self assert: b evaluate equals: 5.
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	b argPermutation: #(1 2).
	b defaultArgs: #(3 4).
	self assert: b evaluate equals: 7
]

{ #category : 'test' }
CommandBlockMorphTest >> testEvaluateWithArgs [

	| b |
	b := self newBlock
		     receiver: self newTestScript;
		     yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs:.
	self assert: (b evaluateWithArgs: #( -5 )) equals: 5.
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	self assert: (b evaluateWithArgs: #( 1 2 )) equals: 3.
	b commandSpec: '%s = %s'.
	b selector: #equal:to:.
	self assert: (b evaluateWithArgs: #( true true )).
	self assert: (b evaluateWithArgs: #( 1 1 )).
	self assert: (b evaluateWithArgs: #( 'a' 'a' )).
	b commandSpec: '%n < %n'.
	b selector: #less:than:.
	self assert: (b evaluateWithArgs: #( 1 2 )).
	self deny: (b evaluateWithArgs: #( 1 1 )).
	self assert: (b evaluateWithArgs: #( '3' '12' )).
	self deny: (b evaluateWithArgs: #( '12' '12' )).
	b commandSpec: '%s < %s'.
	self assert: (b evaluateWithArgs: #( 'a' 'b' )).
	self deny: (b evaluateWithArgs: #( 'a' 'a' ))
]

{ #category : 'test' }
CommandBlockMorphTest >> testIsArgSpec [
	self assert: (CommandBlockMorph isArgSpec: '%a').
	self assert: (CommandBlockMorph isArgSpec: '%b').
	self deny: (CommandBlockMorph isArgSpec: '%').
	self deny: (CommandBlockMorph isArgSpec: 'x')
]

{ #category : 'test' }
CommandBlockMorphTest >> testNumberArgFlags [
	| b |
	b := self newBlock.
	b receiver: self newScript.
	b commandSpec: 'abc %s def %n ghi %e'.
	self assertCollection: b numberArgFlags equals: #(false true false)
]

{ #category : 'test' }
CommandBlockMorphTest >> testOrganizeArgs [
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs.
	self assertCollection: (b organizeArgs: #(1)) equals: #(1).
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	self assertCollection: (b organizeArgs: #(2 3)) equals: #(2 3).
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	b argPermutation: #(2 1).
	self assertCollection: (b organizeArgs: #(2 3)) equals: #(3 2).
	b commandSpec: '%n = %n'.
	b selector: #=.
	b argPermutation: #(2 1).
	self assertCollection: (b organizeArgs: #(2 3)) equals: #(2 3)
]

{ #category : 'test' }
CommandBlockMorphTest >> testParseCommandSpec [

	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc %n')
		equals: #( abc '%n' ).
	self
		assertCollection:
		(CommandBlockMorph parseCommandSpec: 'abc %n    def %s')
		equals: #( abc '%n' def '%s' ).
	self
		assertCollection:
		(CommandBlockMorph parseCommandSpec: 'abc%n1def%s23gh')
		equals: #( abc '%n1' def '%s23' gh ).
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc% def%')
		equals: #( abc '%' def '%' ).
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc % def')
		equals: #( abc '%' def )
]

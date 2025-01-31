"
A ScratchChoiceArgDefTest is a test class for testing the behavior of ScratchChoiceArgDef
"
Class {
	#name : 'ScratchChoiceArgDefTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
ScratchChoiceArgDefTest >> newArgMorphBuilder [

	^ ArgMorphBuilder new
]

{ #category : 'private' }
ScratchChoiceArgDefTest >> newObj [

	^ ScratchChoiceArgDef new
]

{ #category : 'test' }
ScratchChoiceArgDefTest >> testArg [

	| obj |
	obj := self newObj.
	self assert: obj arg isNil.
	obj arg: $a.
	self assert: obj arg equals: $a.
	obj arg: $b.
	self assert: obj arg equals: $b
]

{ #category : 'test' }
ScratchChoiceArgDefTest >> testIsChoiceArg [

	self assert: self newObj isChoiceArg
]

{ #category : 'test' }
ScratchChoiceArgDefTest >> testOptions [

	| obj a |
	obj := self newObj.
	self assert: obj options isNil.
	a := #( a b c ).
	obj options: a.
	self assert: obj options identicalTo: a
]

{ #category : 'test' }
ScratchChoiceArgDefTest >> testPrintOn [

	| obj s |
	obj := self newObj.
	s := WriteStream on: String new.
	obj printOn: s.
	self assert: s contents equals: 'ScratchChoiceArgDef()'.
	obj arg: $a.
	s := WriteStream on: String new.
	obj printOn: s.
	self assert: s contents equals: 'ScratchChoiceArgDef(%a)'.
	obj options: #( a b c ).
	s := WriteStream on: String new.
	obj printOn: s.
	self assert: s contents equals: 'ScratchChoiceArgDef(%a,3)'
]

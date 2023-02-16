"
A ScratchTranslator2Test is a test class for testing the behavior of ScratchTranslator2
"
Class {
	#name : #ScratchTranslatorTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchTranslatorTest >> newFont1 [
	^ StrikeFont familyName: 'Verdana' size: 10
]

{ #category : #private }
ScratchTranslatorTest >> newTranslator [
	^ ScratchTranslator new
]

{ #category : #test }
ScratchTranslatorTest >> testAddMsgIdMsgStr [
	| t |
	t := self newTranslator.
	t addMsgId: 'abc' msgStr: 'def'.
	t addMsgId: '"ghi"' msgStr: '"jkl"'.
	t addMsgId: '""' msgStr: '"mno"'.
	self assert: (t textAt: 'abc') equals: 'def'.
	self assert: (t textAt: 'ghi') equals: 'jkl'.
	self assert: t texts size equals: 2
]

{ #category : #test }
ScratchTranslatorTest >> testDefaultFont [
	| t |
	t := self newTranslator.
	self assert: (t defaultFont isKindOf: AbstractFont)
]

{ #category : #test }
ScratchTranslatorTest >> testDefaultTranslator [

	| obj |
	obj := ScratchTranslator defaultTranslator.
	self assert: obj locale equals: 'en'
]

{ #category : #test }
ScratchTranslatorTest >> testFontAt [
	| t f |
	t := self newTranslator.
	f := self newFont1.
	t fontAt: 'test1' put: f.
	self assert: (t fontAt: 'test1') equals: f.
	self assert: (t fontAt: 'test2') equals: t defaultFont
]

{ #category : #test }
ScratchTranslatorTest >> testFontAtPut [
	self testFontAt
]

{ #category : #test }
ScratchTranslatorTest >> testFonts [
	| t |
	t := self newTranslator.
	self assert: t fonts isDictionary.
	self assert: t fonts isEmpty	
]

{ #category : #test }
ScratchTranslatorTest >> testInitialize [
	| t |
	t := self newTranslator.
	self assert: t fonts isDictionary.
	self assert: t texts isDictionary
]

{ #category : #test }
ScratchTranslatorTest >> testLocale [

	| obj |
	obj := self newTranslator.
	self assert: obj locale isNil.
	obj locale: 'en'.
	self assert: obj locale equals: 'en'.
	obj locale: 'ja'.
	self assert: obj locale equals: 'ja'
]

{ #category : #test }
ScratchTranslatorTest >> testReadFrom [
	| t s |
	t := self newTranslator.
	s := 'msgid "abc"
msgstr "def"

msgid "ghi"
msgstr "jkl"'.
	t readFrom: (ReadStream on: s).
	self assert: (t textAt: 'abc') equals: 'def'.
	self assert: (t textAt: 'ghi') equals: 'jkl'
]

{ #category : #test }
ScratchTranslatorTest >> testTextAt [
	| t |
	t := self newTranslator.
	self assert: (t textAt: 'abc') equals: 'abc'.
	t textAt: 'abc' put: 'def'.
	self assert: (t textAt: 'abc') equals: 'def'
]

{ #category : #test }
ScratchTranslatorTest >> testTextAtPut [
	self testTextAt
]

{ #category : #test }
ScratchTranslatorTest >> testTexts [
	| t |
	t := self newTranslator.
	self assert: t texts isDictionary.
	self assert: t texts isEmpty	
]

{ #category : #test }
ScratchTranslatorTest >> testUnquoteString [
	| t |
	t := self newTranslator.
	self assert: (t unquoteString: '') isEmpty.
	self assert: (t unquoteString: 'abc') equals: 'abc'.
	self assert: (t unquoteString: '  abc   ') equals: 'abc'.
	self assert: (t unquoteString: '  "abc"   ') equals: 'abc'.
	self assert: (t unquoteString: '  "abc   ') equals: 'abc'.
	self assert: (t unquoteString: '  abc"   ') equals: 'abc'
]

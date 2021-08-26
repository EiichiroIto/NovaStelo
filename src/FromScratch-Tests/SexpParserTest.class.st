"
A SexpParserTest is a test class for testing the behavior of SexpParser
"
Class {
	#name : #SexpParserTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
SexpParserTest >> newParser [
	^ SexpParser new
]

{ #category : #test }
SexpParserTest >> testParse [
	| l ret |
	l := #( 'abc' ).
	ret := self newParser parse: l.
	self assert: ret equals: 'abc'.
	l := #( $( 'abc' 'def' $) ).
	ret := self newParser parse: l.
	self assertCollection: ret equals: #(abc def).
	l := #( $( 'abc' 'def' $( 'ghi' $) $) ).
	ret := self newParser parse: l.
	self assertCollection: ret equals: #(abc def (ghi)).
	l := #( $( 'abc' 'def' $( $( 'ghi' $) 'aa' $) $) ).
	ret := self newParser parse: l.
	self assertCollection: ret equals: #(abc def ((ghi) aa)).
	l := #( $( $( $( $) $) $) ).
	ret := self newParser parse: l.
	self assertCollection: ret equals: #((())).
]

{ #category : #test }
SexpParserTest >> testParseItem [
	| in ret |
	in := ReadStream on: #('abc' 'def' $( $( 'ghi' $) 'aa' $) $)).
	ret := self newParser parseItem: in.
	self assert: ret equals: 'abc'.
	self assert: in peek equals: 'def'.
	in := ReadStream on: #($( 'ghi' $) 'aa' $) $)).
	ret := self newParser parseItem: in.
	self assertCollection: ret equals: #('ghi').
	self assert: in peek equals: 'aa'.
]

{ #category : #test }
SexpParserTest >> testParseItemsDelimiter [
	| in list |
	in := ReadStream on: #('abc' 'def' $) 'ghi' $) 'aa' $) $)).
	list := self newParser parseItems: in delimiter: $).
	self assertCollection: list asArray equals: #('abc' 'def').
	self assert: in peek equals: 'ghi'.
	in := ReadStream on: #('abc' $( 'def' $) 'ghi' $) 'aa' $) $)).
	list := self newParser parseItems: in delimiter: $).
	self assertCollection: list asArray equals: #('abc' #('def') 'ghi').
	self assert: in peek equals: 'aa'
]

"
A StringArrayTest is a test class for testing the behavior of StringArray
"
Class {
	#name : #StringArrayTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
StringArrayTest >> newArray [
	^ StringArray new
]

{ #category : #test }
StringArrayTest >> testAt [
	self testAtPut
]

{ #category : #test }
StringArrayTest >> testAtPut [
	| a |
	a := self newArray.
	a forceTo: 1 paddingWith: ''.
	self assert: (a at: 1) equals: 1.
	a at: 1 put: 2.
	self assert: (a at: 1) equals: 2
]

{ #category : #test }
StringArrayTest >> testDefaultElement [
	| a |
	a := self newArray.
	self assert: a defaultElement isString.
	self assert: a defaultElement isEmpty
]

{ #category : #test }
StringArrayTest >> testForceToPaddingWith [
	| a |
	a := self newArray.
	self assert: a size equals: 0.
	a := a forceTo: 2 paddingWith: 'a'.
	self assert: a size equals: 2.
	self assert: (a stringAt: 1) equals: 'a'.
	self assert: (a stringAt: 2) equals: 'a'.
	a stringAt: 1 put: 'c'.
	a stringAt: 2 put: 'd'.
	a := a forceTo: 4 paddingWith: 'b'.
	self assert: a size equals: 4.
	self assert: (a stringAt: 1) equals: 'c'.
	self assert: (a stringAt: 2) equals: 'd'.
	self assert: (a stringAt: 3) equals: 'b'.
	self assert: (a stringAt: 4) equals: 'b'
]

{ #category : #test }
StringArrayTest >> testGenerateInvLiterals [
	| a x y |
	a := self newArray.
	a := a forceTo: 4 paddingWith: ''.
	a stringAt: 1 put: 'abc'.
	a stringAt: 2 put: 'def'.
	a stringAt: 3 put: 'abc'.
	a stringAt: 4 put: 'ghi'.
	x := a privInvLiterals copy.
	y := a generateInvLiterals.
	self assert: x equals: y
]

{ #category : #test }
StringArrayTest >> testGrownBy [
	| a |
	a := self newArray.
	self assert: a size equals: 0.
	a := a grownBy: 1.
	self assert: a size equals: 1.
	self assert: (a stringAt: 1) equals: ''.
	a := a grownBy: 2.
	self assert: a size equals: 3.
	self assert: (a stringAt: 1) equals: ''.
	self assert: (a stringAt: 2) equals: ''.
	self assert: (a stringAt: 3) equals: ''
]

{ #category : #test }
StringArrayTest >> testIdOf [
	| d x |
	d := self newArray.
	x := d idOf: 'abc'.
	self assert: x equals: 1.
	self assert: (d privLiterals at: x) equals: 'abc'.
	x := d idOf: 'def'.
	self assert: x equals: 2.
	self assert: (d privLiterals at: x) equals: 'def'.
	x := d idOf: 'abc'.
	self assert: x equals: 1.
	self assert: (d privLiterals at: x) equals: 'abc'
]

{ #category : #test }
StringArrayTest >> testInitialize [
	| a |
	a := self newArray.
	self assert: (a privArray isKindOf: IntegerArray).
	self assert: a privLiterals isArray.
	self assert: a privInvLiterals isNil
]

{ #category : #test }
StringArrayTest >> testInvLiterals [
	| a x y |
	a := self newArray.
	a := a forceTo: 4 paddingWith: ''.
	a stringAt: 1 put: 'abc'.
	a stringAt: 2 put: 'def'.
	a stringAt: 3 put: 'abc'.
	a stringAt: 4 put: 'ghi'.
	x := a privInvLiterals copy.
	a privInvLiterals: nil.
	y := a invLiterals.
	self assert: x equals: y.
	self assert: a privInvLiterals equals: y
]

{ #category : #test }
StringArrayTest >> testIsEmpty [
	| a |
	a := self newArray.
	self assert: a isEmpty.
	a := a forceTo: 1 paddingWith: ''.
	self deny: a isEmpty
]

{ #category : #test }
StringArrayTest >> testPrivArray [
	| a |
	a := self newArray.
	self assert: (a privArray isKindOf: IntegerArray)
]

{ #category : #test }
StringArrayTest >> testPrivInvLiterals [
	| a |
	a := self newArray.
	self assert: a privInvLiterals isNil.
	a invLiterals.
	self assert: a privInvLiterals isDictionary.
	a privInvLiterals: nil.
	self assert: a privInvLiterals isNil
]

{ #category : #test }
StringArrayTest >> testPrivLiterals [
	| a |
	a := self newArray.
	self assert: a privLiterals isArray
]

{ #category : #test }
StringArrayTest >> testSize [
	| a |
	a := self newArray.
	self assert: a size equals: 0.
	a := a forceTo: 1 paddingWith: ''.
	self assert: a size equals: 1
]

{ #category : #test }
StringArrayTest >> testStringAt [
	self testStringAtPut
]

{ #category : #test }
StringArrayTest >> testStringAtPut [
	| a |
	a := self newArray.
	a := a forceTo: 3 paddingWith: ''.
	a stringAt: 1 put: 'a'.
	a stringAt: 2 put: 'b'.
	a stringAt: 3 put: 'c'.
	self assert: (a stringAt: 1) equals: 'a'.
	self assert: (a stringAt: 2) equals: 'b'.
	self assert: (a stringAt: 3) equals: 'c'.
	self should: [ a stringAt: 4 ] raise: Error
]

{ #category : #test }
StringArrayTest >> testStringOf [
	| a |
	a := self newArray.
	self assert: (a stringOf: 0) equals: ''.
	a forceTo: 1 paddingWith: 'a'.
	self assert: (a stringOf: 1) equals: 'a'
]

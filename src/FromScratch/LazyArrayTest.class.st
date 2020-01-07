"
A LasyArrayTest is a test class for testing the behavior of LasyArray
"
Class {
	#name : #LazyArrayTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #'instance creation' }
LazyArrayTest >> newArray: aSymbol [
	^ LazyArray className: aSymbol
]

{ #category : #test }
LazyArrayTest >> testAllocateMore [
	| l |
	l := LazyArray className: #FloatArray.
	l allocateMore: 10.
	self assert: (l privArray isKindOf: FloatArray).
	self assert: l privArray size equals: l defaultAllocationSize.
	l allocateMore: 10.
	self assert: (l privArray isKindOf: FloatArray).
	self assert: l privArray size equals: l defaultAllocationSize * 2.
]

{ #category : #test }
LazyArrayTest >> testArray [
	| a |
	a := self newArray: #FloatArray.
	self assert: a array class equals: FloatArray.
	self assert: a array size equals: 0.
	a at: 10 put: 1.
	self assert: a array class equals: FloatArray.
	self assert: a array size equals: 100.
	self assert: (a array at: 10) equals: 1
]

{ #category : #test }
LazyArrayTest >> testArrayClass [
	| l |
	l := LazyArray basicNew.
	l className: #FloatArray.
	self assert: l arrayClass equals: FloatArray.
	l := LazyArray basicNew.
	l className: #ByteArray.
	self assert: l arrayClass equals: ByteArray.
]

{ #category : #test }
LazyArrayTest >> testAssureExistsIndex [
	| a |
	a := self newArray: #Array.
	self assert: a privArray isNil.
	a assureExistsIndex: 10.
	a at: 9 put: 1.
	a at: 10 put: 2.
	self assert: a privArray isArray.
	self assert: a privArray size equals: 100.
	a assureExistsIndex: 20.
	self assert: a privArray isArray.
	self assert: a privArray size equals: 100.
	self assert: (a at: 9) equals: 1.
	self assert: (a at: 10) equals: 2.
]

{ #category : #test }
LazyArrayTest >> testAssureExistsIndexAnd [
	| a |
	a := self newArray: #Array.
	a defaultValue: 2.
	self assert: a privArray isNil.
	a assureExistsIndex: 10 and: 20.
	self assert: a privArray isArray.
	self assert: a privArray size equals: 100.
	self assert: (a at: 10) isCollection.
	self assert: (a at: 10) size equals: 20.
	self assert: ((a at: 10) at: 1) equals: 2.
	self assert: ((a at: 10) at: 20) equals: 2.
]

{ #category : #test }
LazyArrayTest >> testAt [
	| l a |
	l := LazyArray basicNew.
	self assert: (l at: 1) equals: 0.
	a := FloatArray new: 5.
	a at: 2 put: 3.
	a at: 5 put: 9.
	l privArray: a.
	self assert: (l at: 1) equals: 0.0.
	self assert: (l at: 2) equals: 3.0.
	self assert: (l at: 3) equals: 0.0.
	self assert: (l at: 4) equals: 0.0.
	self assert: (l at: 5) equals: 9.0.
	self assert: (l at: 6) equals: 0.0.
]

{ #category : #test }
LazyArrayTest >> testAtPut [
	| l |
	l := LazyArray className: #FloatArray.
	self assert: l privArray isNil.
	l at: 1 put: 1.
	self assert: l privArray size equals: l defaultAllocationSize.
	self assert: (l at: 1) equals: 1.
	l at: 2 put: 2.
	l at: 3 put: 3.
	self assert: (l at: 1) equals: 1.
	self assert: (l at: 2) equals: 2.
	self assert: (l at: 3) equals: 3.
	l at: 103 put: 103.
	self assert: l privArray size equals: l defaultAllocationSize * 2.
	self assert: (l at: 1) equals: 1.
	self assert: (l at: 2) equals: 2.
	self assert: (l at: 3) equals: 3.
	self assert: (l at: 103) equals: 103.
]

{ #category : #test }
LazyArrayTest >> testClassName [
	| l |
	l := LazyArray basicNew.
	self assert: l className isNil.
	l className: #FloatArray.
	self assert: l className equals: #FloatArray
]

{ #category : #test }
LazyArrayTest >> testDefaultAllocationSize [
	| l |
	l := LazyArray basicNew.
	self assert: l defaultAllocationSize equals: 100.
]

{ #category : #test }
LazyArrayTest >> testDefaultValue [
	| a |
	a := self newArray: #FloatArray.
	self assert: a defaultValue equals: 0.
	a defaultValue: 12.
	self assert: a defaultValue equals: 12.
	self should: [ a defaultValue: 10 ] raise: Error
]

{ #category : #test }
LazyArrayTest >> testFixedSize [
	self testPrivFixedSize.
]

{ #category : #test }
LazyArrayTest >> testForceSize [
	| l |
	l := LazyArray className: #FloatArray.
	self assert: l size equals: 0.
	l at: 20 put: 1.
	self assert: l size equals: l defaultAllocationSize.
	l forceSize: 10.
	self assert: l size equals: 10.
	l forceSize: 20.
	self assert: l size equals: 20.
	l reset.
	self should: [ l at: 30 put: 1 ] raise: Error.
]

{ #category : #test }
LazyArrayTest >> testIsEmpty [
	| l |
	l := LazyArray className: #FloatArray.
	self assert: l isEmpty.
	l at: 1 put: 2.
	self deny: l isEmpty.
	l reset.
	self assert: l isEmpty.
]

{ #category : #test }
LazyArrayTest >> testIsFixed [
	| l |
	l := LazyArray className: #FloatArray.
	self deny: l isFixed.
	l at: 20 put: 1.
	self deny: l isFixed.
	l forceSize: 10.
	self assert: l isFixed.
	l reset.
	self assert: l isFixed.
]

{ #category : #test }
LazyArrayTest >> testList [
	| a ret |
	a := self newArray: #Array.
	a list: 3 set: #(10 20 30).
	ret := (a list: 1).
	self assertCollection: ret equals: #().
	self assertCollection: (a list: 2) equals: #().
	self assertCollection: (a list: 3) equals: #(10 20 30)
]

{ #category : #test }
LazyArrayTest >> testListAdd [
	| a |
	a := self newArray: #Array.
	a defaultValue: 0.
	self assert: (a list: 5 at: 2) equals: 0.
	a list: 5 add: 10.
	a list: 5 add: 20.
	self assert: (a list: 5 at: 1) equals: 10.
	self assert: (a list: 5 at: 2) equals: 20.
]

{ #category : #test }
LazyArrayTest >> testListAt [
	| a |
	a := self newArray: #Array.
	a defaultValue: ''.
	self assert: (a list: 5 at: 2) equals: ''.
	self assert: a privArray size equals: 100.
	self assert: a privArray first equals: nil.
	self assert: a privArray fifth equals: nil.
	a assureExistsIndex: 5 and: 3.
	self assert: (a list: 5 at: 2) equals: ''.
	self assert: a privArray fifth class equals: OrderedCollection.
	self assert: a privArray fifth size equals: 3.
	self assert: a privArray fifth first equals: ''.
	self assert: a privArray fifth second equals: ''.
	self assert: a privArray fifth third equals: ''.
]

{ #category : #test }
LazyArrayTest >> testListAtPut [
	| a |
	a := self newArray: #Array.
	a defaultValue: ''.
	self assert: (a list: 5 at: 2) equals: ''.
	a list: 5 at: 2 put: 'a'.
	a list: 5 at: 3 put: 'b'.
	self assert: (a list: 5 at: 1) equals: ''.
	self assert: (a list: 5 at: 2) equals: 'a'.
	self assert: (a list: 5 at: 3) equals: 'b'
]

{ #category : #test }
LazyArrayTest >> testListContains [
	| a |
	a := self newArray: #Array.
	a defaultValue: 0.
	self assert: (a list: 5 at: 2) equals: 0.
	a list: 5 add: 10.
	a list: 5 add: 20.
	a list: 5 add: 30.
	self assert: (a list: 5 at: 1) equals: 10.
	self assert: (a list: 5 at: 2) equals: 20.
	self assert: (a list: 5 at: 3) equals: 30.
	self assert: (a list: 5 contains: 10).
	self assert: (a list: 5 contains: 20).
	self assert: (a list: 5 contains: 30).
	self deny: (a list: 5 contains: 0).
	self deny: (a list: 5 contains: 40).
]

{ #category : #test }
LazyArrayTest >> testListRemove [
	| a |
	a := self newArray: #Array.
	a defaultValue: 0.
	self assert: (a list: 5 at: 2) equals: 0.
	a list: 5 add: 10.
	a list: 5 add: 20.
	a list: 5 add: 30.
	self assert: (a list: 5 at: 1) equals: 10.
	self assert: (a list: 5 at: 2) equals: 20.
	self assert: (a list: 5 at: 3) equals: 30.
	a list: 5 remove: 2.
	self assert: (a list: 5 at: 1) equals: 10.
	self assert: (a list: 5 at: 2) equals: 30.
	self assert: (a listSizeOf: 5) equals: 2.
]

{ #category : #test }
LazyArrayTest >> testListSet [
	| a |
	a := self newArray: #Array.
	a defaultValue: 0.
	a list: 5 set: #(10 20 30).
	self assert: (a list: 5 at: 1) equals: 10.
	self assert: (a list: 5 at: 2) equals: 20.
	self assert: (a list: 5 at: 3) equals: 30
]

{ #category : #test }
LazyArrayTest >> testListSizeOf [
	| a |
	a := self newArray: #Array.
	a defaultValue: ''.
	self assert: (a listSizeOf: 5) equals: 0.
	a list: 5 at: 2 put: 'a'.
	self assert: (a listSizeOf: 5) equals: 2.
	a list: 5 at: 3 put: 'a'.
	self assert: (a listSizeOf: 5) equals: 3.
]

{ #category : #test }
LazyArrayTest >> testMultiplyBy [
	| l |
	l := LazyArray className: #FloatArray.
	l at: 1 put: 10.
	l at: 2 put: 20.
	l at: 3 put: 30.
	self assert: (l at: 1) equals: 10.
	self assert: (l at: 2) equals: 20.
	self assert: (l at: 3) equals: 30.
	l multiplyBy: 2.
	self assert: (l at: 1) equals: 20.
	self assert: (l at: 2) equals: 40.
	self assert: (l at: 3) equals: 60
]

{ #category : #test }
LazyArrayTest >> testPrintOn [
	| a st |
	a := self newArray: #FloatArray.
	st := WriteStream on: ''.
	a printOn: st.
	self assert: st contents equals: 'LazyArray(FloatArray,0)'.
	a at: 3 put: 10.
	st := WriteStream on: ''.
	a printOn: st.
	self assert: st contents equals: 'LazyArray(FloatArray,100)'.
	a forceSize: 10.
	st := WriteStream on: ''.
	a printOn: st.
	self assert: st contents equals: 'LazyArray(FloatArray,*10)'.
]

{ #category : #test }
LazyArrayTest >> testPrivArray [
	| l a b |
	l := LazyArray basicNew.
	self assert: l privArray isNil.
	a := #(1 2 3).
	b := #(4 5 6).
	l privArray: a.
	self assertCollection: l privArray equals: a.
	l privArray: b.
	self assertCollection: l privArray equals: b.
]

{ #category : #test }
LazyArrayTest >> testPrivFixedSize [
	| l |
	l := LazyArray className: #FloatArray.
	self assert: l fixedSize isNil.
	l privFixedSize: 10.
	self assert: l fixedSize equals: 10.
	l privFixedSize: 20.
	self assert: l fixedSize equals: 20.
]

{ #category : #test }
LazyArrayTest >> testReset [
	| l |
	l := LazyArray className: #FloatArray.
	self assert: l privArray isNil.
	l at: 1 put: 1.
	self assert: l privArray notNil.
	l reset.
	self assert: l privArray isNil.
	l at: 1 put: 1.
	self assert: l privArray notNil.
]

{ #category : #test }
LazyArrayTest >> testSetArray [
	| l a b |
	l := LazyArray className: #FloatArray.
	self assert: l privArray isNil.
	a := #(1 2 3) asFloatArray.
	b := #(4 5 6) asFloatArray.
	l privArray: a.
	self assertCollection: l privArray equals: a.
	l setArray: b.
	self assertCollection: l privArray equals: b.
	self should: [l setArray: #(4 5 6)] raise: Error.
]

{ #category : #test }
LazyArrayTest >> testSize [
	| l a |
	l := LazyArray basicNew.
	self assert: l size equals: 0.
	a := FloatArray new: 5.
	a at: 2 put: 3.
	a at: 5 put: 9.
	l privArray: a.
	self assert: l size equals: 5.
]

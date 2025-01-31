"
A ScratchBlockCategoryTest is a test class for testing the behavior of ScratchBlockCategory
"
Class {
	#name : 'ScratchBlockCategoryTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
ScratchBlockCategoryTest >> newObj [

	^ ScratchBlockCategory new
]

{ #category : 'test' }
ScratchBlockCategoryTest >> testCategoryName [

	| obj |
	obj := self newObj.
	self assert: obj categoryName isNil.
	obj categoryName: 'abc'.
	self assert: obj categoryName equals: 'abc'.
	obj categoryName: 'def'.
	self assert: obj categoryName equals: 'def'
]

{ #category : 'test' }
ScratchBlockCategoryTest >> testIsCategory [

	self assert: self newObj isCategory
]

{ #category : 'test' }
ScratchBlockCategoryTest >> testPrintOn [

	| obj s |
	obj := self newObj.
	s := WriteStream on: String new.
	obj printOn: s.
	self assert: s contents equals: 'ScratchBlockCategory(nil)'.
	obj categoryName: 'abc'.
	s := WriteStream on: String new.
	obj printOn: s.
	self assert: s contents equals: 'ScratchBlockCategory(abc)'
]

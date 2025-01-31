"
An AbstractBlockSpecTest is a test class for testing the behavior of AbstractBlockSpec
"
Class {
	#name : 'AbstractBlockSpecTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'test' }
AbstractBlockSpecTest >> testBlockCategory [

	| obj |
	obj := AbstractBlockSpec blockCategory: 'abc'.
	self assert: (obj isKindOf: ScratchBlockCategory).
	self assert: obj isCategory.
	self assert: obj categoryName equals: 'abc'
]

{ #category : 'test' }
AbstractBlockSpecTest >> testBooleanReporterSelectorArguments [

	| obj |
	obj := AbstractBlockSpec
		       booleanReporter: 'abc'
		       selector: #def
		       arguments: #(  ).
	self assert: (obj isKindOf: ScratchBlockSpec).
	self assert: obj isBooleanReporter
]

{ #category : 'test' }
AbstractBlockSpecTest >> testCBlockSelectorArguments [

	| obj |
	obj := AbstractBlockSpec
		       cBlock: 'abc'
		       selector: #def
		       arguments: #(  ).
	self assert: (obj isKindOf: ScratchBlockSpec).
	self assert: obj isCBlock
]

{ #category : 'test' }
AbstractBlockSpecTest >> testCommandSelectorArguments [

	| obj |
	obj := AbstractBlockSpec
		       command: 'abc'
		       selector: #def
		       arguments: #(  ).
	self assert: (obj isKindOf: ScratchBlockSpec).
	self assert: obj isCommandBlock
]

{ #category : 'test' }
AbstractBlockSpecTest >> testEventHatBlockSelectorEventName [

	| obj |
	obj := AbstractBlockSpec
		       eventHatBlock: 'abc'
		       selector: #def
		       eventName: 'ghi'.
	self assert: (obj isKindOf: ScratchBlockSpec).
	self assert: obj isEventHatBlock.
	self assert: obj selector equals: #def.
	self assert: obj arguments first equals: 'ghi'
]

{ #category : 'test' }
AbstractBlockSpecTest >> testIsBlockMorph [

	self deny: AbstractBlockSpec new isBlockMorph
]

{ #category : 'test' }
AbstractBlockSpecTest >> testIsBlockSpec [

	self deny: AbstractBlockSpec new isBlockSpec
]

{ #category : 'test' }
AbstractBlockSpecTest >> testIsCategory [

	self deny: AbstractBlockSpec new isCategory
]

{ #category : 'test' }
AbstractBlockSpecTest >> testIsChoiceArg [

	self deny: AbstractBlockSpec new isChoiceArg
]

{ #category : 'test' }
AbstractBlockSpecTest >> testIsSeparator [

	self deny: AbstractBlockSpec new isSeparator
]

{ #category : 'test' }
AbstractBlockSpecTest >> testReporterSelectorArguments [

	| obj |
	obj := AbstractBlockSpec
		       reporter: 'abc'
		       selector: #def
		       arguments: #(  ).
	self assert: (obj isKindOf: ScratchBlockSpec).
	self assert: obj isReporterBlock
]

{ #category : 'test' }
AbstractBlockSpecTest >> testSeparator [

	| obj |
	obj := AbstractBlockSpec separator.
	self assert: (obj isKindOf: ScratchBlockSeparator).
	self assert: obj isSeparator
]

{ #category : 'test' }
AbstractBlockSpecTest >> testSpecialSelectorArguments [

	| obj |
	obj := AbstractBlockSpec
		       special: 'abc'
		       selector: #def
		       arguments: #(  ).
	self assert: (obj isKindOf: ScratchBlockSpec).
	self assert: obj isSpecialForm
]

{ #category : 'test' }
AbstractBlockSpecTest >> testStartHatBlockSelectorEventName [

	| obj |
	obj := AbstractBlockSpec
		       startHatBlock: 'abc'
		       selector: #def.
	self assert: (obj isKindOf: ScratchBlockSpec).
	self assert: obj isStartHatBlock.
	self assert: obj selector equals: #def.
	self assert: obj arguments isEmpty
]

{ #category : 'test' }
AbstractBlockSpecTest >> testTimedSelectorArguments [

	| obj |
	obj := AbstractBlockSpec timed: 'abc' selector: #def arguments: #(  ).
	self assert: (obj isKindOf: ScratchBlockSpec).
	self assert: obj isTimedBlock
]

"
A ScratchBlockSpecTest is a test class for testing the behavior of ScratchBlockSpec
"
Class {
	#name : #ScratchBlockSpecTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchBlockSpecTest >> newObj [

	^ ScratchBlockSpec new
]

{ #category : #test }
ScratchBlockSpecTest >> testArguments [

	| obj a |
	obj := self newObj.
	self assert: obj arguments isNil.
	a := #( 1 2 3 ).
	obj arguments: a.
	self assert: obj arguments identicalTo: a
]

{ #category : #test }
ScratchBlockSpecTest >> testColor [

	| obj |
	obj := self newObj.
	self assert: obj color isNil.
	obj color: Color red.
	self assert: obj color equals: Color red
]

{ #category : #test }
ScratchBlockSpecTest >> testIsBlockSpec [

	self assert: self newObj isBlockSpec
]

{ #category : #test }
ScratchBlockSpecTest >> testIsBooleanReporter [

	| obj |
	obj := self newObj.
	self deny: obj isBooleanReporter.
	obj type: #isBooleanReporter.
	self assert: obj isBooleanReporter
]

{ #category : #test }
ScratchBlockSpecTest >> testIsCBlock [

	| obj |
	obj := self newObj.
	self deny: obj isCBlock.
	obj type: #isCBlock.
	self assert: obj isCBlock
]

{ #category : #test }
ScratchBlockSpecTest >> testIsCommandBlock [

	| obj |
	obj := self newObj.
	self deny: obj isCommandBlock.
	obj type: #isCommandBlock.
	self assert: obj isCommandBlock
]

{ #category : #test }
ScratchBlockSpecTest >> testIsEventHatBlock [

	| obj |
	obj := self newObj.
	self deny: obj isEventHatBlock.
	obj type: #isEventHatBlock.
	self assert: obj isEventHatBlock
]

{ #category : #test }
ScratchBlockSpecTest >> testIsNativeBlock [

	self assert: self newObj isNativeBlock
]

{ #category : #test }
ScratchBlockSpecTest >> testIsReporterBlock [

	| obj |
	obj := self newObj.
	self deny: obj isReporterBlock.
	obj type: #isBooleanReporter.
	self assert: obj isReporterBlock.
	obj type: #isReporterBlock.
	self assert: obj isReporterBlock
]

{ #category : #test }
ScratchBlockSpecTest >> testIsSpecialForm [

	| obj |
	obj := self newObj.
	self deny: obj isSpecialForm.
	obj type: #isSpecialForm.
	self assert: obj isSpecialForm
]

{ #category : #test }
ScratchBlockSpecTest >> testIsStartHatBlock [

	| obj |
	obj := self newObj.
	self deny: obj isStartHatBlock.
	obj type: #isStartHatBlock.
	self assert: obj isStartHatBlock
]

{ #category : #test }
ScratchBlockSpecTest >> testIsTimedBlock [

	| obj |
	obj := self newObj.
	self deny: obj isTimedBlock.
	obj type: #isTimedBlock.
	self assert: obj isTimedBlock
]

{ #category : #test }
ScratchBlockSpecTest >> testLabel [

	| obj |
	obj := self newObj.
	self assert: obj label isNil.
	obj label: 'init %a'.
	self assert: obj label equals: 'init %a'.
	obj label: 'return'.
	self assert: obj label equals: 'return'
]

{ #category : #test }
ScratchBlockSpecTest >> testPrintOn [

	| obj s |
	obj := self newObj.
	s := WriteStream on: String new.
	obj printOn: s.
	self assert: s contents equals: 'ScratchBlockSpec(nil,nil,nil)'.
	obj label: 'abc'.
	obj type: 'r'.
	obj selector: #def.
	s := WriteStream on: String new.
	obj printOn: s.
	self assert: s contents equals: 'ScratchBlockSpec(abc,r,def)'
]

{ #category : #test }
ScratchBlockSpecTest >> testSelector [

	| obj |
	obj := self newObj.
	self assert: obj selector isNil.
	obj selector: #abc.
	self assert: obj selector equals: #abc.
	obj selector: #def.
	self assert: obj selector equals: #def
]

{ #category : #test }
ScratchBlockSpecTest >> testType [

	| obj |
	obj := self newObj.
	self assert: obj type isNil.
	obj selector: #-.
	self assert: obj selector equals: #-.
	obj selector: #r.
	self assert: obj selector equals: #r
]

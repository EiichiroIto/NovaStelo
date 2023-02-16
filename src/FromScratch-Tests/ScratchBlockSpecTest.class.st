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
	obj type: #b.
	self assert: obj isBooleanReporter.
	#( C E K M S T L G c r s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isBooleanReporter ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsCBlock [

	| obj |
	obj := self newObj.
	self deny: obj isCBlock.
	obj type: #c.
	self assert: obj isCBlock.
	#( C E K M S T L G b r s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isCBlock ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsCommandBlock [

	| obj |
	obj := self newObj.
	self deny: obj isCommandBlock.
	obj type: #-.
	self assert: obj isCommandBlock.
	#( C E K M S T L G c b r s t ) do: [ :each | 
		obj type: each.
		self deny: obj isCommandBlock ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsEventHatBlock [

	| obj |
	obj := self newObj.
	self deny: obj isEventHatBlock.
	obj type: #E.
	self assert: obj isEventHatBlock.
	#( C K M S T L G c b r s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isEventHatBlock ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsHatBlock [

	| obj |
	obj := self newObj.
	self deny: obj isHatBlock.
	#( C E K M S T L G ) do: [ :each | 
		obj type: each.
		self assert: obj isHatBlock ].
	#( c b r s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isHatBlock ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsLoopHatBlock [

	| obj |
	obj := self newObj.
	self deny: obj isLoopHatBlock.
	obj type: #L.
	self assert: obj isLoopHatBlock.
	#( C E K M S T G c b r s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isLoopHatBlock ]
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
	obj type: #b.
	self assert: obj isReporterBlock.
	obj type: #r.
	self assert: obj isReporterBlock.
	#( C E K M S T L G c s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isReporterBlock ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsSetupHatBlock [

	| obj |
	obj := self newObj.
	self deny: obj isSetupHatBlock.
	obj type: #S.
	self assert: obj isSetupHatBlock.
	#( C E K M L T G c b r s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isSetupHatBlock ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsSpecialForm [

	| obj |
	obj := self newObj.
	self deny: obj isSpecialForm.
	obj type: #s.
	self assert: obj isSpecialForm.
	#( C E K M S T L G b c r t - ) do: [ :each | 
		obj type: each.
		self deny: obj isSpecialForm ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsStartHatBlock [

	| obj |
	obj := self newObj.
	self deny: obj isStartHatBlock.
	obj type: #G.
	self assert: obj isStartHatBlock.
	#( C E K M S T L c b r s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isStartHatBlock ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsStartupHatBlock [

	| obj |
	obj := self newObj.
	self deny: obj isStartupHatBlock.
	obj type: #T.
	self assert: obj isStartupHatBlock.
	#( C E K M S L G c b r s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isStartupHatBlock ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsSubHatBlock [

	| obj |
	obj := self newObj.
	self deny: obj isSubHatBlock.
	obj type: #C.
	self assert: obj isSubHatBlock.
	#( L E K M S T G c b r s t - ) do: [ :each | 
		obj type: each.
		self deny: obj isSubHatBlock ]
]

{ #category : #test }
ScratchBlockSpecTest >> testIsTimedBlock [

	| obj |
	obj := self newObj.
	self deny: obj isTimedBlock.
	obj type: #t.
	self assert: obj isTimedBlock.
	#( C E K M S T L G b c r s - ) do: [ :each | 
		obj type: each.
		self deny: obj isTimedBlock ]
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

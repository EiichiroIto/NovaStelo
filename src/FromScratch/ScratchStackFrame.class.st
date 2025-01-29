Class {
	#name : 'ScratchStackFrame',
	#superclass : 'Object',
	#instVars : [
		'parentFrame',
		'expression',
		'arguments',
		'pc',
		'startTime',
		'startValue',
		'shouldUnlight',
		'localVars'
	],
	#category : 'FromScratch-Process',
	#package : 'FromScratch',
	#tag : 'Process'
}

{ #category : 'accessing' }
ScratchStackFrame >> addArgument: anObject [
	arguments add: anObject
]

{ #category : 'accessing' }
ScratchStackFrame >> arguments [
	^ arguments
]

{ #category : 'accessing' }
ScratchStackFrame >> arguments: anObject [
	arguments := anObject
]

{ #category : 'accessing' }
ScratchStackFrame >> expression [
	^ expression
]

{ #category : 'accessing' }
ScratchStackFrame >> expression: anObject [
	expression := anObject
]

{ #category : 'testing' }
ScratchStackFrame >> hasLocalVar: aString [
	^ localVars
		ifNil: [ false ]
		ifNotNil: [ localVars includesKey: aString ]
]

{ #category : 'initialization' }
ScratchStackFrame >> initialize [

	arguments := OrderedCollection new.
	pc := 1.
	shouldUnlight := false
]

{ #category : 'api' }
ScratchStackFrame >> localVarAt: aString [
	^ localVars ifNil: [ nil ] ifNotNil: [ localVars at: aString ]
]

{ #category : 'api' }
ScratchStackFrame >> localVarAt: aString put: anObject [
	localVars ifNil: [ localVars := Dictionary new ].
	localVars at: aString put: anObject
]

{ #category : 'accessing' }
ScratchStackFrame >> localVars [
	^ localVars
]

{ #category : 'accessing' }
ScratchStackFrame >> localVars: aDictionary [
	localVars := aDictionary
]

{ #category : 'accessing' }
ScratchStackFrame >> parentFrame [
	^ parentFrame
]

{ #category : 'accessing' }
ScratchStackFrame >> parentFrame: anObject [
	parentFrame := anObject
]

{ #category : 'accessing' }
ScratchStackFrame >> pc [
	^ pc
]

{ #category : 'accessing' }
ScratchStackFrame >> pc: anObject [
	pc := anObject
]

{ #category : 'api' }
ScratchStackFrame >> recursiveLocalVarAt: aString [
	(self hasLocalVar: aString)
		ifTrue: [ ^ self localVarAt: aString ].
	^ self parentFrame
		ifNil: [ nil ]
		ifNotNil: [ :frame | frame recursiveLocalVarAt: aString ]
]

{ #category : 'accessing' }
ScratchStackFrame >> shouldUnlight [
	^ shouldUnlight
]

{ #category : 'accessing' }
ScratchStackFrame >> shouldUnlight: anObject [
	shouldUnlight := anObject
]

{ #category : 'accessing' }
ScratchStackFrame >> shouldYield [
	"Answers true iff this is a dummy frame simply indicating that the process should yield control."

	^ expression = #shouldYield
]

{ #category : 'accessing' }
ScratchStackFrame >> shouldYield: aBoolean [
	"Makes this into a special stack frame that tells the evaluator to yield control to another process. When this flag is set, the rest of the stack frame is ignored."

	aBoolean
		ifTrue: [ expression := #shouldYield ]
		ifFalse: [ self error: 'Should not call shouldYield: with false.' ]
]

{ #category : 'accessing' }
ScratchStackFrame >> startTime [
	^ startTime
]

{ #category : 'accessing' }
ScratchStackFrame >> startTime: anObject [
	startTime := anObject
]

{ #category : 'accessing' }
ScratchStackFrame >> startValue [
	^ startValue
]

{ #category : 'accessing' }
ScratchStackFrame >> startValue: anObject [
	startValue := anObject
]

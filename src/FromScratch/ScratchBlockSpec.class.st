Class {
	#name : 'ScratchBlockSpec',
	#superclass : 'AbstractBlockSpec',
	#instVars : [
		'label',
		'type',
		'selector',
		'arguments',
		'color'
	],
	#category : 'FromScratch-Project',
	#package : 'FromScratch',
	#tag : 'Project'
}

{ #category : 'accessing' }
ScratchBlockSpec >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ScratchBlockSpec >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
ScratchBlockSpec >> color [

	^ color
]

{ #category : 'accessing' }
ScratchBlockSpec >> color: anObject [

	color := anObject
]

{ #category : 'testing' }
ScratchBlockSpec >> isBlockSpec [

	^ true
]

{ #category : 'testing' }
ScratchBlockSpec >> isBooleanReporter [

	^ type = #isBooleanReporter
]

{ #category : 'testing' }
ScratchBlockSpec >> isCBlock [

	^ type = #isCBlock
]

{ #category : 'testing' }
ScratchBlockSpec >> isCommandBlock [

	^ type = #isCommandBlock
]

{ #category : 'testing' }
ScratchBlockSpec >> isEventHatBlock [

	^ type = #isEventHatBlock
]

{ #category : 'testing' }
ScratchBlockSpec >> isNativeBlock [

	^ true
]

{ #category : 'testing' }
ScratchBlockSpec >> isReporterBlock [

	^ #(isReporterBlock isBooleanReporter) includes: type
]

{ #category : 'testing' }
ScratchBlockSpec >> isSpecialForm [

	^ type = #isSpecialForm
]

{ #category : 'testing' }
ScratchBlockSpec >> isStartHatBlock [

	^ type = #isStartHatBlock
]

{ #category : 'testing' }
ScratchBlockSpec >> isTimedBlock [

	^ type = #isTimedBlock
]

{ #category : 'accessing' }
ScratchBlockSpec >> label [

	^ label
]

{ #category : 'accessing' }
ScratchBlockSpec >> label: anObject [

	label := anObject
]

{ #category : 'printing' }
ScratchBlockSpec >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: label asString;
		nextPut: $,;
		nextPutAll: type asString;
		nextPut: $,;
		nextPutAll: selector asString;
		nextPut: $)
]

{ #category : 'accessing' }
ScratchBlockSpec >> selector [

	^ selector
]

{ #category : 'accessing' }
ScratchBlockSpec >> selector: anObject [

	selector := anObject
]

{ #category : 'accessing' }
ScratchBlockSpec >> type [

	^ type
]

{ #category : 'accessing' }
ScratchBlockSpec >> type: anObject [

	type := anObject
]

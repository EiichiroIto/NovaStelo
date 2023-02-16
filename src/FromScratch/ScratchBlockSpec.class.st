Class {
	#name : #ScratchBlockSpec,
	#superclass : #AbstractBlockSpec,
	#instVars : [
		'label',
		'type',
		'selector',
		'arguments',
		'color'
	],
	#category : #'FromScratch-Project'
}

{ #category : #accessing }
ScratchBlockSpec >> arguments [

	^ arguments
]

{ #category : #accessing }
ScratchBlockSpec >> arguments: anObject [

	arguments := anObject
]

{ #category : #accessing }
ScratchBlockSpec >> color [

	^ color
]

{ #category : #accessing }
ScratchBlockSpec >> color: anObject [

	color := anObject
]

{ #category : #testing }
ScratchBlockSpec >> isBlockSpec [

	^ true
]

{ #category : #testing }
ScratchBlockSpec >> isBooleanReporter [

	^ type = #b
]

{ #category : #testing }
ScratchBlockSpec >> isCBlock [

	^ type = #c
]

{ #category : #testing }
ScratchBlockSpec >> isCommandBlock [

	^ type = #-
]

{ #category : #testing }
ScratchBlockSpec >> isEventHatBlock [

	^ type = #E
]

{ #category : #testing }
ScratchBlockSpec >> isHatBlock [

	^ #( C E K M S T L G ) includes: type
]

{ #category : #testing }
ScratchBlockSpec >> isLoopHatBlock [

	^ type = #L
]

{ #category : #testing }
ScratchBlockSpec >> isNativeBlock [

	^ true
]

{ #category : #testing }
ScratchBlockSpec >> isReporterBlock [

	^ #(r b) includes: type
]

{ #category : #testing }
ScratchBlockSpec >> isSetupHatBlock [

	^ type = #S
]

{ #category : #testing }
ScratchBlockSpec >> isSpecialForm [

	^ type = #s
]

{ #category : #testing }
ScratchBlockSpec >> isStartHatBlock [

	^ type = #G
]

{ #category : #testing }
ScratchBlockSpec >> isStartupHatBlock [

	^ type = #T
]

{ #category : #testing }
ScratchBlockSpec >> isSubHatBlock [

	^ type = #C
]

{ #category : #testing }
ScratchBlockSpec >> isTimedBlock [

	^ type = #t
]

{ #category : #accessing }
ScratchBlockSpec >> label [

	^ label
]

{ #category : #accessing }
ScratchBlockSpec >> label: anObject [

	label := anObject
]

{ #category : #printing }
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

{ #category : #accessing }
ScratchBlockSpec >> selector [

	^ selector
]

{ #category : #accessing }
ScratchBlockSpec >> selector: anObject [

	selector := anObject
]

{ #category : #accessing }
ScratchBlockSpec >> type [

	^ type
]

{ #category : #accessing }
ScratchBlockSpec >> type: anObject [

	type := anObject
]

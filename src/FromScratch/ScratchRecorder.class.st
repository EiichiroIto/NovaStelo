Class {
	#name : 'ScratchRecorder',
	#superclass : 'Object',
	#instVars : [
		'writer',
		'rate',
		'count',
		'extent',
		'model'
	],
	#category : 'FromScratch-Morphic',
	#package : 'FromScratch',
	#tag : 'Morphic'
}

{ #category : 'accessing' }
ScratchRecorder >> close [
	self isOpen
		ifFalse: [ ^ self ].
	writer close.
	writer := nil
]

{ #category : 'private' }
ScratchRecorder >> defaultFrameDelay [
	^ 10
]

{ #category : 'accessing' }
ScratchRecorder >> extent [
	^ extent
]

{ #category : 'accessing' }
ScratchRecorder >> extent: aPoint [
	extent := aPoint.
]

{ #category : 'initialization' }
ScratchRecorder >> initialize [
	super initialize.
	rate := 1.
	count := 0.
]

{ #category : 'testing' }
ScratchRecorder >> isOpen [
	^ writer notNil
]

{ #category : 'private' }
ScratchRecorder >> makeForm [
	| form frame |
	form := model stageShotExtent: extent.
	form := form as8BitColorForm.
	frame := AnimatedImageFrame new
		delay: self defaultFrameDelay;
		form: form.
	^ frame
]

{ #category : 'accessing' }
ScratchRecorder >> model [
	^ model
]

{ #category : 'accessing' }
ScratchRecorder >> model: aSpPresenter [
	model := aSpPresenter
]

{ #category : 'accessing' }
ScratchRecorder >> openFileNamed: aString [
	self close.
	writer := GIFReadWriter on: aString asFileReference binaryWriteStream.
	writer ifNil: [ ^ self ].
	count := 0.
]

{ #category : 'accessing' }
ScratchRecorder >> rate: anInteger [
	rate := anInteger.
	count := 0.
]

{ #category : 'accessing' }
ScratchRecorder >> writeForced: aBoolean [
	self isOpen
		ifFalse: [ ^ self ].
	count := count + 1.
	(aBoolean or: [ count >= rate ])
		ifFalse: [ ^ self ].
	writer nextPutFrame: self makeForm.
	count := 0.
]

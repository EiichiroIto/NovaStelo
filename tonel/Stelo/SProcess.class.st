Class {
	#name : #SProcess,
	#superclass : #SteloProcess,
	#instVars : [
		'runningEvents',
		'transition'
	],
	#category : #'Stelo-Process'
}

{ #category : #'instance creation' }
SProcess class >> new [
	self shouldNotImplement
]

{ #category : #transitions }
SProcess >> afterLoop [
	runningEvents isEmpty
		ifTrue: [ self loop ]
]

{ #category : #transitions }
SProcess >> afterSetup [
	runningEvents isEmpty
		ifTrue: [ self stop ]
]

{ #category : #transitions }
SProcess >> afterSingle [
	runningEvents isEmpty
		ifTrue: [ self stop ]
]

{ #category : #transitions }
SProcess >> afterStartup [
	runningEvents isEmpty
		ifTrue: [ self setup ]
]

{ #category : #execution }
SProcess >> doOneCycle [
	runningEvents
		do: [ :eventNo | 
			| eventCodes |
			eventCodes := program forEventNo: eventNo.
			eventCodes isEmpty
				ifFalse: [ self
						executeEventCodes: eventCodes
						ifTerminatedDo: [ self stop.
							^ false ] ] ].
	^ false
]

{ #category : #execution }
SProcess >> executeEventCodes: anEventCodes ifTerminatedDo: aBlock [
	1 to: sworld maxBreedNo do: [ :bno | 
		| codes |
		codes := anEventCodes forBreedNo: bno.
		codes
			do: [ :code | 
				sworld
					livingBreed: bno
					do: [ :index | 
						self
							executeThread: code
							breedNo: bno
							index: index
							ifTerminatedDo: aBlock ] ] ].
]

{ #category : #execution }
SProcess >> executeThread: entryPoint breedNo: bno index: index ifTerminatedDo: aBlock [
	| thread |
	thread := SteloNativeThread sworld: sworld.
	thread forBreedNo: bno index: index.
	thread codes: program codes.
	thread execute: entryPoint.
	thread isTerminated
		ifTrue: [ aBlock value ].
]

{ #category : #transitions }
SProcess >> idle [
	"do nothing"
]

{ #category : #initialization }
SProcess >> initialize [
	super initialize.
	self stop.
]

{ #category : #testing }
SProcess >> isRunning [
	^ transition ~= #idle
]

{ #category : #accessing }
SProcess >> loop [
	transition := #afterLoop.
	runningEvents := {EventId loopEventNo}.
]

{ #category : #private }
SProcess >> privRunningEvents [
	^ runningEvents
]

{ #category : #private }
SProcess >> privRunningEvents: aCollection [
	runningEvents := aCollection.
]

{ #category : #private }
SProcess >> privTransition [
	^ transition
]

{ #category : #private }
SProcess >> privTransition: aSymbol [
	transition := aSymbol.
]

{ #category : #accessing }
SProcess >> setup [
	transition := #afterSetup.
	runningEvents := {EventId setupEventNo}.
]

{ #category : #accessing }
SProcess >> single [
	transition := #afterSingle.
	runningEvents := {EventId singleEventNo}.
]

{ #category : #accessing }
SProcess >> startup [
	transition := #afterStartup.
	runningEvents := {EventId startupEventNo}.
	sworld clearTicks.
]

{ #category : #accessing }
SProcess >> step [
	self isRunning
		ifFalse: [ ^ self ].
	sworld
		clearRaisedEvents;
		incrementTicks.
	[ self doOneCycle ] whileTrue.
	self isRunning
		ifFalse: [ ^ self ].
	runningEvents := sworld raisedEvents copy.
	self perform: transition.
]

{ #category : #accessing }
SProcess >> stop [
	transition := #idle.
	runningEvents := #().
]

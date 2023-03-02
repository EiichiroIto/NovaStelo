Class {
	#name : #SteloNativeProcess,
	#superclass : #SteloProcess,
	#instVars : [
		'runningEvents',
		'transition'
	],
	#category : #'Stelo-Process'
}

{ #category : #'instance creation' }
SteloNativeProcess class >> new [
	self shouldNotImplement
]

{ #category : #transitions }
SteloNativeProcess >> afterLoop [
	runningEvents isEmpty
		ifTrue: [ self loop ]
]

{ #category : #transitions }
SteloNativeProcess >> afterSetup [
	runningEvents isEmpty
		ifTrue: [ self stop ]
]

{ #category : #transitions }
SteloNativeProcess >> afterSingle [
	runningEvents isEmpty
		ifTrue: [ self stop ]
]

{ #category : #transitions }
SteloNativeProcess >> afterStartup [
	runningEvents isEmpty
		ifTrue: [ self setup ]
]

{ #category : #execution }
SteloNativeProcess >> doOneCycle [
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

{ #category : #api }
SteloNativeProcess >> event: eno [
	transition := #afterSingle.
	runningEvents := {eno}
]

{ #category : #execution }
SteloNativeProcess >> executeEventCodes: anEventCodes ifTerminatedDo: aBlock [
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
SteloNativeProcess >> executeThread: entryPoint breedNo: bno index: index ifTerminatedDo: aBlock [
	| thread |
	thread := SteloNativeThread sworld: sworld.
	thread forBreedNo: bno index: index.
	thread codes: program codes.
	thread execute: entryPoint.
	thread isTerminated
		ifTrue: [ aBlock value ].
]

{ #category : #transitions }
SteloNativeProcess >> idle [
	"do nothing"
]

{ #category : #initialization }
SteloNativeProcess >> initialize [
	super initialize.
	self stop.
]

{ #category : #testing }
SteloNativeProcess >> isRunning [
	^ transition ~= #idle
]

{ #category : #api }
SteloNativeProcess >> loop [
	transition := #afterLoop.
	runningEvents := {EventId loopEventNo}.
]

{ #category : #accessing }
SteloNativeProcess >> runningEvents [
	^ runningEvents
]

{ #category : #accessing }
SteloNativeProcess >> runningEvents: aCollection [
	runningEvents := aCollection.
]

{ #category : #api }
SteloNativeProcess >> setup [
	transition := #afterSetup.
	runningEvents := {EventId setupEventNo}.
]

{ #category : #api }
SteloNativeProcess >> single [
	transition := #afterSingle.
	runningEvents := {EventId singleEventNo}.
]

{ #category : #api }
SteloNativeProcess >> startup [
	transition := #afterStartup.
	runningEvents := {EventId startupEventNo}.
	sworld clearTicks.
]

{ #category : #api }
SteloNativeProcess >> step [
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

{ #category : #api }
SteloNativeProcess >> stop [
	transition := #idle.
	runningEvents := #().
]

{ #category : #accessing }
SteloNativeProcess >> transition [
	^ transition
]

{ #category : #accessing }
SteloNativeProcess >> transition: aSymbol [
	transition := aSymbol.
]

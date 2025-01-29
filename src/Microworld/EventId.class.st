Class {
	#name : 'EventId',
	#superclass : 'BaseId',
	#category : 'Microworld-Core',
	#package : 'Microworld',
	#tag : 'Core'
}

{ #category : 'accessing' }
EventId class >> loopEventNo [
	^ 3
]

{ #category : 'private' }
EventId class >> reservedNo [
	^ 4
]

{ #category : 'accessing' }
EventId class >> setupEventNo [
	^ 2
]

{ #category : 'accessing' }
EventId class >> singleEventNo [
	^ 4
]

{ #category : 'accessing' }
EventId class >> startupEventNo [
	^ 1
]

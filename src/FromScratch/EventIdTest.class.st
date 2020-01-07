"
A SEventIdTest is a test class for testing the behavior of SEventId
"
Class {
	#name : #EventIdTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #test }
EventIdTest >> testLoopEventNo [
	self assert: EventId loopEventNo equals: 3.
]

{ #category : #test }
EventIdTest >> testReservedNo [
	self assert: EventId reservedNo equals: EventId singleEventNo.
]

{ #category : #test }
EventIdTest >> testSetupEventNo [
	self assert: EventId setupEventNo equals: 2.
]

{ #category : #test }
EventIdTest >> testSingleEventNo [
	self assert: EventId singleEventNo equals: 4.
]

{ #category : #test }
EventIdTest >> testStartupEventNo [
	self assert: EventId startupEventNo equals: 1.
]

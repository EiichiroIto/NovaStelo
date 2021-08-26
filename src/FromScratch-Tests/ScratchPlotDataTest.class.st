"
A ScratchPlotDataTest is a test class for testing the behavior of ScratchPlotData
"
Class {
	#name : #ScratchPlotDataTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchPlotDataTest >> newPlotData [
	^ ScratchPlotData new
]

{ #category : #test }
ScratchPlotDataTest >> testChannel [
	| p |
	p := self newPlotData.
	self assert: p channel isNil.
	p channel: 1.
	self assert: p channel equals: 1.
	p channel: 2.
	self assert: p channel equals: 2
]

{ #category : #test }
ScratchPlotDataTest >> testData [
	| p |
	p := self newPlotData.
	self assert: p data isNil.
	p data: 1.0.
	self assert: p data equals: 1.0.
	p data: 2.5.
	self assert: p data equals: 2.5
]

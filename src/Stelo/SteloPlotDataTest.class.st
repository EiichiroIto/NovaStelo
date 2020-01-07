"
A SteloPlotDataTest is a test class for testing the behavior of SteloPlotData
"
Class {
	#name : #SteloPlotDataTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SteloPlotDataTest >> newPlotData [
	^ SteloPlotData new
]

{ #category : #test }
SteloPlotDataTest >> testChannel [
	| p |
	p := self newPlotData.
	self assert: p channel isNil.
	p channel: 1.
	self assert: p channel equals: 1.
	p channel: 2.
	self assert: p channel equals: 2
]

{ #category : #test }
SteloPlotDataTest >> testData [
	| p |
	p := self newPlotData.
	self assert: p data isNil.
	p data: 1.0.
	self assert: p data equals: 1.0.
	p data: 2.5.
	self assert: p data equals: 2.5
]

"
A SteloPlotCommandTest is a test class for testing the behavior of SteloPlotCommand
"
Class {
	#name : #SteloPlotCommandTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'instance creation' }
SteloPlotCommandTest >> newPlotCommand [
	^ SteloPlotCommand new
]

{ #category : #test }
SteloPlotCommandTest >> testCommand [
	| p |
	p := self newPlotCommand.
	self assert: p command isNil.
	p command: 1.
	self assert: p command equals: 1.
	p command: 2.
	self assert: p command equals: 2
]

{ #category : #test }
SteloPlotCommandTest >> testIsClearPlot [
	| p |
	p := self newPlotCommand.
	self deny: p isClearPlot.
	p command: p class clearPlotNo.
	self assert: p isClearPlot
]

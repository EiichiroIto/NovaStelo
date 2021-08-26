"
A ScratchPlotCommandTest is a test class for testing the behavior of ScratchPlotCommand
"
Class {
	#name : #ScratchPlotCommandTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #'instance creation' }
ScratchPlotCommandTest >> newPlotCommand [
	^ ScratchPlotCommand new
]

{ #category : #test }
ScratchPlotCommandTest >> testCommand [
	| p |
	p := self newPlotCommand.
	self assert: p command isNil.
	p command: 1.
	self assert: p command equals: 1.
	p command: 2.
	self assert: p command equals: 2
]

{ #category : #test }
ScratchPlotCommandTest >> testIsClearPlot [
	| p |
	p := self newPlotCommand.
	self deny: p isClearPlot.
	p command: p class clearPlotNo.
	self assert: p isClearPlot
]

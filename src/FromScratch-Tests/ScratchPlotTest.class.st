Class {
	#name : 'ScratchPlotTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'test' }
ScratchPlotTest >> testClearPlots [
	| p |
	p := ScratchPlot clearPlots.
	self assert: p isClearPlot
]

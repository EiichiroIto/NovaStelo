Class {
	#name : #SteloPlotTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #test }
SteloPlotTest >> testClearPlots [
	| p |
	p := SteloPlot clearPlots.
	self assert: p isClearPlot
]

"
A SteloPlotColorTest is a test class for testing the behavior of SteloPlotColor
"
Class {
	#name : #SteloPlotColorTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SteloPlotColorTest >> newPlotColor [
	^ SteloPlotColor new
]

{ #category : #test }
SteloPlotColorTest >> testChannel [
	| p |
	p := self newPlotColor.
	self assert: p channel isNil.
	p channel: 1.
	self assert: p channel equals: 1.
	p channel: 2.
	self assert: p channel equals: 2
]

{ #category : #test }
SteloPlotColorTest >> testColor [
	| p |
	p := self newPlotColor.
	self assert: p color isNil.
	p color: Color red.
	self assert: p color equals: Color red.
	p color: Color blue.
	self assert: p color equals: Color blue
]
